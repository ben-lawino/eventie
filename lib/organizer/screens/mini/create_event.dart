import 'dart:io';
import 'package:eventie/data/models/ticket_model.dart';
import 'package:eventie/organizer/providers/event_provider.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/custom_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/categories.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/event_model.dart';
import '../../bottom_nav.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  CategoryModel? selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _regularPriceController = TextEditingController();
  final _vipPriceController = TextEditingController();
  final _vvipPriceController = TextEditingController();
  final _locationController = TextEditingController();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select date & time')),
      );
      return;
    }

    if (_regularPriceController.text.isEmpty &&
        _vipPriceController.text.isEmpty &&
        _vvipPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one ticket')),
      );
      return;
    }

    final eventDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // Build tickets
    final List<TicketModel> tickets = [];

    if (_regularPriceController.text.isNotEmpty) {
      tickets.add(TicketModel(
        name: 'Regular',
        price: double.parse(_regularPriceController.text),
      ));
    }

    if (_vipPriceController.text.isNotEmpty) {
      tickets.add(TicketModel(
        name: 'VIP',
        price: double.parse(_vipPriceController.text),
      ));
    }

    if (_vvipPriceController.text.isNotEmpty) {
      tickets.add(TicketModel(
        name: 'VVIP',
        price: double.parse(_vvipPriceController.text),
      ));
    }

    final now = DateTime.now();

    final event = EventModel(
      id: const Uuid().v4(),           // safe unique ID
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      eventDate: eventDateTime,
      location: _locationController.text.trim(),
      imageUrl: _selectedImage?.path,
      category: selectedCategory!.name,
      organizerId: 'user_1',           // TODO: replace with auth
      tickets: tickets,
      createdAt: now,
      updatedAt: now,
    );

    ref.read(eventsProvider.notifier).addEvent(event);

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!context.mounted) return;  // guard against unmounted context
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BottomNav()),
          );
        });

        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 60, color: Colors.green),
              SizedBox(height: 10),
              Text('Event Submitted'),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _regularPriceController.dispose();
    _vipPriceController.dispose();
    _vvipPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Event',
       onBackPressed: (){
          Navigator.pop(context);
       },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                label: 'Title',
                validator: (v) => v!.isEmpty ? 'Enter title' : null,
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: _locationController,
                label: 'Location',
                validator: (v) => v!.isEmpty ? 'Enter location' : null,
              ),

              const SizedBox(height: 12),

              // Date picker
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                      _dateController.text =
                      '${picked.day}/${picked.month}/${picked.year}';
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Time picker
              TextField(
                controller: _timeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Time'),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                      _timeController.text = picked.format(context);
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Category dropdown
              DropdownButtonFormField<CategoryModel>(
                initialValue: selectedCategory,
                hint: const Text('Select Category'),
                items: eventCategories.map((c) {
                  return DropdownMenuItem(
                    value: c,
                    child: Text(c.name),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedCategory = v),
                validator: (v) => v == null ? 'Select category' : null,
              ),

              const SizedBox(height: 12),

              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'Enter description' : null,
              ),

              const SizedBox(height: 12),

              // Ticket prices
              CustomTextField(
                controller: _regularPriceController,
                label: 'Regular Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _vipPriceController,
                label: 'VIP Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _vvipPriceController,
                label: 'VVIP Price',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 12),

              // Image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _selectedImage == null
                      ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image_outlined, size: 32, color: Colors.grey),
                        SizedBox(height: 6),
                        Text('Tap to pick image',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Button(
                text: 'Submit',
                width: double.infinity,
                onPressed: _submit,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}