import 'dart:io';
import 'package:eventie/common/providers/theme_provider.dart';
import 'package:eventie/common/screens/help_center_screen.dart';
import 'package:eventie/common/screens/language_setting_screen.dart';
import 'package:eventie/common/screens/notification_setting_screen.dart';
import 'package:eventie/common/screens/security_setting_screen.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/log_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isEditing = false;
  bool _isSaving = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String? _localAvatarPath;

  @override
  void initState() {
    super.initState();
    final p = ref.read(profileProvider);
    _nameController  = TextEditingController(text: p.fullName);
    _emailController = TextEditingController(text: p.email);
    _phoneController = TextEditingController(text: p.phone);
    _localAvatarPath = p.avatarPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ── Image picker ──────────────────────────────────────────────────────────

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _localAvatarPath = picked.path);
  }

  // ── Cancel ────────────────────────────────────────────────────────────────

  void _cancelEdit() {
    final p = ref.read(profileProvider);
    _nameController.text  = p.fullName;
    _emailController.text = p.email;
    _phoneController.text = p.phone;
    setState(() {
      _localAvatarPath = p.avatarPath;
      _isEditing = false;
    });
  }

  // ── Save ──────────────────────────────────────────────────────────────────

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);

    await Future.delayed(const Duration(milliseconds: 600));

    ref.read(profileProvider.notifier).update(
      ref.read(profileProvider).copyWith(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        avatarPath: _localAvatarPath,
      ),
    );

    setState(() {
      _isSaving = false;
      _isEditing = false;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  // ── Logout overlay ────────────────────────────────────────────────────────

  void _logOutOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        child: const LogOut(),
      ),
    );
  }

  // ── Field builder ─────────────────────────────────────────────────────────

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        keyboardType: keyboardType,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          filled: true,
          fillColor: _isEditing
              ? primary.withOpacity(0.08)
              : Colors.grey.withOpacity(0.07),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary.withOpacity(0.3)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary, width: 1.5),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final profile = ref.watch(profileProvider);

    final ImageProvider avatarImage = _localAvatarPath != null
        ? FileImage(File(_localAvatarPath!))
        : const AssetImage('assets/images/profilepic.png');

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        backDestination: NavigationMenu(),
        actions: [
          _isSaving
              ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
              : TextButton(
            onPressed: () {
              if (_isEditing) {
                _saveProfile();
              } else {
                setState(() => _isEditing = true);
              }
            },
            child: Text(
              _isEditing ? 'Save' : 'Edit',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          // ── Avatar ──────────────────────────────────────────────────────
          Center(
            child: Stack(
              children: [
                CircleAvatar(radius: 60, backgroundImage: avatarImage),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Name (non-edit mode)
          if (!_isEditing)
            Center(
              child: Text(
                profile.fullName,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

          const SizedBox(height: 20),

          // ── Fields ──────────────────────────────────────────────────────
          _buildEditableField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person_outline,
          ),
          _buildEditableField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildEditableField(
            controller: _phoneController,
            label: 'Phone',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),

          // Cancel button
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: TextButton(
                onPressed: _cancelEdit,
                child: Text('Cancel',
                    style: TextStyle(color: Colors.grey[600])),
              ),
            ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          // ── Settings ─────────────────────────────────────────────────────
          ListTile(
            leading: Image.asset('assets/icons/calendar.png', scale: 24),
            title: Text('Manage Events',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500)),
            trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          _buildNavTile(
            icon: 'assets/icons/notification.png',
            label: 'Notification',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const NotificationSettingScreen())),
          ),
          _buildNavTile(
            icon: 'assets/icons/payment.png',
            label: 'Payments',
            onTap: () {},
          ),
          _buildNavTile(
            icon: 'assets/icons/security.png',
            label: 'Security',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SecuritySettingScreen())),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          SwitchListTile(
            value: ref.watch(themeProvider) == ThemeMode.dark,
            onChanged: (_) =>
                ref.read(themeProvider.notifier).toggleTheme(),
            title: const Text('Dark Mode'),
            secondary: Image.asset('assets/icons/moon.png', scale: 24),
            activeColor: Colors.white,
            activeTrackColor: primaryColor,
          ),

          _buildNavTile(
            icon: 'assets/icons/language.png',
            label: 'Language',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const LanguageSettingScreen())),
          ),
          _buildNavTile(
            icon: 'assets/icons/help.png',
            label: 'Help Center',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const HelpCenterScreen())),
          ),
          _buildNavTile(
            icon: 'assets/icons/friends.png',
            label: 'Invite Friends',
            onTap: () {},
          ),
          _buildNavTile(
            icon: 'assets/icons/star.png',
            label: 'Rate us',
            onTap: () {},
          ),

          GestureDetector(
            onTap: _logOutOverlay,
            child: ListTile(
              leading: Image.asset('assets/icons/exit.png',
                  scale: 24, color: Colors.red),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Image.asset(icon, scale: 24),
        title: Text(label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500)),
        trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
      ),
    );
  }
}