import 'package:eventie/customer/navigation.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/log_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/providers/theme_provider.dart';
import '../../common/screens/help_center_screen.dart';
import '../../common/screens/language_setting_screen.dart';
import '../../common/screens/notification_setting_screen.dart';
import '../../common/screens/security_setting_screen.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isEditing = false;
  bool _isDarkMode = false;

  final TextEditingController _nameController =
  TextEditingController(text: 'Ben Lawin');
  final TextEditingController _emailController =
  TextEditingController(text: 'benlawin@email.com');
  final TextEditingController _phoneController =
  TextEditingController(text: '+254 712 345 678');
  final TextEditingController _bioController =
  TextEditingController(text: 'Event enthusiast 🎉');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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

  void _saveProfile() {
    setState(() => _isEditing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: TextField(
        controller: controller,
        enabled: _isEditing,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          filled: true,
          fillColor: _isEditing
              ? Theme.of(context).colorScheme.primary.withOpacity(0.08)
              : Colors.grey.withOpacity(0.07),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        backDestination: NavigationMenu(),
        actions: [
          TextButton(
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

          // ── Avatar ──────────────────────────────────────────
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                  const AssetImage('assets/images/profilepic.png'),
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: image picker
                      },
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

          // Name display (non-edit mode)
          if (!_isEditing)
            Center(
              child: Text(
                _nameController.text,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

          const SizedBox(height: 20),

          // ── Editable Fields ─────────────────────────────────
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
          _buildEditableField(
            controller: _bioController,
            label: 'Bio',
            icon: Icons.edit_note_outlined,
            maxLines: 2,
          ),

          // Cancel button (only in edit mode)
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: TextButton(
                onPressed: () => setState(() => _isEditing = false),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          // ── Settings List ────────────────────────────────────
          ListTile(
            leading:
            Image.asset('assets/icons/calendar.png', scale: 24),
            title: Text(
              'Manage Events',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            trailing:
            Image.asset('assets/icons/arrowright.png', scale: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          _buildNavTile(
            icon: 'assets/icons/notification.png',
            label: 'Notification',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => NotificationSettingScreen())),
          ),
          _buildNavTile(
            icon: 'assets/icons/payment.png',
            label: 'Payments',
            onTap: () {},
          ),
          _buildNavTile(
            icon: 'assets/icons/security.png',
            label: 'Security',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => SecuritySettingScreen())),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Divider(color: Colors.grey[400], thickness: 1, height: 20),
          ),

          // Dark Mode Toggle
          SwitchListTile(
            value: ref.watch(themeProvider) == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            title: Text('Dark Mode'),
            secondary: Image.asset('assets/icons/moon.png', scale: 24),
            activeColor: Colors.white,
            activeTrackColor: primaryColor,
          ),

          _buildNavTile(
            icon: 'assets/icons/language.png',
            label: 'Language',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => LanguageSettingScreen())),
          ),
          _buildNavTile(
            icon: 'assets/icons/help.png',
            label: 'Help Center',
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => HelpCenterScreen())),
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

          // Logout
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
        title: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        trailing: Image.asset('assets/icons/arrowright.png', scale: 24),
      ),
    );
  }
}