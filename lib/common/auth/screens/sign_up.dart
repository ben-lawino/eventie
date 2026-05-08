import 'package:eventie/customer/navigation.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/role_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController           = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey                   = GlobalKey<FormState>();

  bool _acceptTerms = false;
  bool _isLoading   = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── Sign up ───────────────────────────────────────────────────────────────

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptTerms) {
      setState(() => _errorMessage = 'Please accept the terms to continue');
      return;
    }

    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    // Simulate async auth — swap for Firebase later
    await Future.delayed(const Duration(milliseconds: 800));

    // Role was set when they tapped a card on the welcome screen
    // Now we persist it to SharedPreferences
    final role = ref.read(roleProvider) ?? 'customer';
    await ref.read(roleProvider.notifier).saveRole(role);

    setState(() => _isLoading = false);

    if (!mounted) return;
    _routeByRole(role);
  }

  // ── Route after sign up ───────────────────────────────────────────────────

  void _routeByRole(String role) {
    final destination = role == 'organizer'
        ? const BottomNav()
        : const NavigationMenu();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
          (route) => false,
    );
  }

  // ── Validators ────────────────────────────────────────────────────────────

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    return regex.hasMatch(v.trim()) ? null : 'Enter a valid email';
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Password is required';
    return v.length < 6 ? 'Password must be at least 6 characters' : null;
  }

  String? _confirmPasswordValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please confirm your password';
    return v != _passwordController.text ? 'Passwords do not match' : null;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final selectedRole = ref.watch(roleProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('assets/icons/applogo.png', scale: 5),

                    Text(
                      'Create Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),

                    // ── Role indicator ─────────────────────────────────────
                    if (selectedRole != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              selectedRole == 'organizer'
                                  ? Icons.event_available_rounded
                                  : Icons.person_rounded,
                              size: 16,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Signing up as ${selectedRole[0].toUpperCase()}${selectedRole.substring(1)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 30),

                    // ── Email ──────────────────────────────────────────────
                    LoginTextField(
                      hintText: 'Email',
                      icon: Icons.email_rounded,
                      controller: _emailController,
                      validator: _emailValidator,
                    ),

                    const SizedBox(height: 20),

                    // ── Password ───────────────────────────────────────────
                    LoginTextField(
                      hintText: 'Password',
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      controller: _passwordController,
                      validator: _passwordValidator,
                    ),

                    const SizedBox(height: 20),

                    // ── Confirm password ───────────────────────────────────
                    LoginTextField(
                      hintText: 'Confirm Password',
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      validator: _confirmPasswordValidator,
                    ),

                    const SizedBox(height: 20),

                    // ── Error message ──────────────────────────────────────
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // ── Terms ──────────────────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms  = value!;
                              _errorMessage = null;
                            });
                          },
                          activeColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  const TextSpan(text: 'I accept the Eventie '),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ', '),
                                  TextSpan(
                                    text: 'Community Guidelines',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ', and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' (Required)',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ── Sign up button ─────────────────────────────────────
                    Button(
                      onPressed: _isLoading ? null : _signUp,
                      text: _isLoading ? 'Creating account...' : 'Sign Up',
                      width: double.infinity,
                      height: 50,
                    ),

                    const SizedBox(height: 25),

                    // ── Or continue with ───────────────────────────────────
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                                color: Color(0xFFE0E0E0), thickness: 1)),
                        SizedBox(width: 6),
                        Text('or continue with'),
                        SizedBox(width: 6),
                        Expanded(
                            child: Divider(
                                color: Color(0xFFE0E0E0), thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // ── Google ─────────────────────────────────────────────
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset('assets/icons/google.png', scale: 24),
                    ),

                    const SizedBox(height: 25),

                    // ── Already have an account ────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}