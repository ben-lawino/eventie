import 'dart:io';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/profile_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameCtrl;
  late TextEditingController _dobCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  String? _selectedGender;
  String? _selectedCountry;
  String? _avatarUrl;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = ['Kenya', 'Uganda', 'Tanzania', 'Nigeria', 'South Africa'];

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _fullNameCtrl = TextEditingController(text: profile.fullName);
    _dobCtrl = TextEditingController(text: profile.dateOfBirth);
    _emailCtrl = TextEditingController(text: profile.email);
    _phoneCtrl = TextEditingController(text: profile.phone);
    _selectedGender = profile.gender;
    _selectedCountry = profile.country;
    _avatarUrl = profile.avatarUrl;
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _dobCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  // ── Image picker

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _avatarUrl = picked.path);
  }

  // ── Date picker

  Future<void> _pickDate() async {
    final initial = _parseDate(_dobCtrl.text) ?? DateTime(1990);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobCtrl.text = DateFormat('M/d/yyyy').format(picked);
    }
  }

  DateTime? _parseDate(String value) {
    try {
      return DateFormat('M/d/yyyy').parse(value);
    } catch (_) {
      return null;
    }
  }

  // ── Save

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Simulate async work (swap for real API call later)
    await Future.delayed(const Duration(milliseconds: 600));

    ref.read(profileProvider.notifier).update(
      ref.read(profileProvider).copyWith(
        fullName: _fullNameCtrl.text.trim(),
        dateOfBirth: _dobCtrl.text.trim(),
        gender: _selectedGender,
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        country: _selectedCountry,
        avatarUrl: _avatarUrl,
      ),
    );

    setState(() => _isSaving = false);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
    Navigator.pop(context);
  }

  // ── Validators

  String? _requiredValidator(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    return regex.hasMatch(v.trim()) ? null : 'Enter a valid email';
  }

  String? _phoneValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone is required';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    return digits.length < 9 ? 'Enter a valid phone number' : null;
  }

  // ── Build

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // ── Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _avatarUrl != null
                        ? (_avatarUrl!.startsWith('http')
                            ? NetworkImage(_avatarUrl!)
                            : FileImage(File(_avatarUrl!))) as ImageProvider
                        : const AssetImage('assets/images/profilepic.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.edit, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Full name
              ProfileField(
                controller: _fullNameCtrl,
                label: 'Full Name',
                validator: _requiredValidator,
              ),
              const SizedBox(height: 15),

              // ── Date of birth
              ProfileField(
                controller: _dobCtrl,
                label: 'Date of Birth',
                readOnly: true,
                suffixIcon: Icons.calendar_today,
                onSuffixTap: _pickDate,
                onTap: _pickDate,
                validator: _requiredValidator,
              ),
              const SizedBox(height: 15),

              // ── Gender dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                decoration: _dropdownDecoration('Gender'),
                items: _genders
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedGender = v),
                validator: (v) => v == null ? 'Select a gender' : null,
              ),
              const SizedBox(height: 15),

              // ── Email
              ProfileField(
                controller: _emailCtrl,
                label: 'Email',
                suffixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
              ),
              const SizedBox(height: 15),

              // ── Phone
              ProfileField(
                controller: _phoneCtrl,
                label: 'Phone',
                prefixWidget: const Text('ke '),
                keyboardType: TextInputType.phone,
                validator: _phoneValidator,
              ),
              const SizedBox(height: 15),

              // ── Country dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCountry,
                decoration: _dropdownDecoration('Country'),
                items: _countries
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCountry = v),
                validator: (v) => v == null ? 'Select a country' : null,
              ),
              const SizedBox(height: 30),

              // ── Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}