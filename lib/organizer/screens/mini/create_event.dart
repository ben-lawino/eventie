import 'dart:io';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../../data/categories.dart';
import '../../../data/models/category_model.dart';
import '../../bottom_nav.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  CategoryModel? selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();



  //controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _vipPriceController = TextEditingController();
  final TextEditingController _vvipPriceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          contentPadding: const EdgeInsets.only(
            top: 30,
            left: 40,
            right: 40,
            bottom: 25,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                'Event Submitted!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Your event has been sent for approval. You will be redirected shortly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNav()),
            );
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Create Event',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //title
                  CustomTextField(
                    controller: _titleController,
                    label: 'Title',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),

                  //date
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Event Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;

                          _dateController.text =
                              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                        });
                      }
                    },
                  ),

                  SizedBox(height: 18),

                  //time
                  TextField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Event Time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        setState(() {
                          selectedTime = pickedTime;
                          _timeController.text = pickedTime.format(context);
                        });
                      }
                    },
                  ),
                  SizedBox(height: 18),

                  //location
                  CustomTextField(
                      controller: _locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Location is required';
                        }
                        return null;
                      },
                      label: 'Location'),
                  SizedBox(height: 18),

                  //categories
                  DropdownButtonFormField<CategoryModel>(
                    value: selectedCategory,
                    hint: Text('Select Category'),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    items: eventCategories.map((category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),

                  SizedBox(height: 18),

                  //description
                  CustomTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(14),
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //regular ticket
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Regular',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _regularPriceController,
                                  keyboardType: TextInputType.number,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter price',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //vip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('VIP',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _vipPriceController,
                                  keyboardType: TextInputType.number,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter price',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //vvip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('VVIP',
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  controller: _vvipPriceController,
                                  keyboardType: TextInputType.number,
                                  onTapOutside: (event) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter price',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),

                  //image picker
                  GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _selectedImage == null
                          ? Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.image_outlined),
                                  SizedBox(width: 10),
                                  Text("Upload Event Posters"),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 18),

                  Button(
                      text: 'Submit for Approval',
                      width: double.infinity,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // if (_selectedImage == null) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(12),
                          //         ),
                          //         backgroundColor: Colors.white,
                          //         content: Center(
                          //             child: Text('Please upload event poster',
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .labelSmall!
                          //                     .copyWith(
                          //                         color: Theme.of(context)
                          //                             .colorScheme
                          //                             .primary,
                          //                         fontWeight:
                          //                             FontWeight.bold)))),
                          //   );
                          //   return;
                          // }

                          if (selectedDate == null || selectedTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Center(
                                    child: Text('Select date and time',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold)),
                                  )),
                            );
                            return;
                          }

                          if (_regularPriceController.text.isEmpty &&
                              _vipPriceController.text.isEmpty &&
                              _vvipPriceController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  content: Center(
                                    child: Text(
                                        'Enter at least one ticket price',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold)),
                                  )),
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
                          _showSuccessDialog(context);
                        }

                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
