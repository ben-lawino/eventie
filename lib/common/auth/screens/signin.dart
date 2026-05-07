import 'package:eventie/common/auth/screens/sign_up.dart';
import 'package:eventie/customer/navigation.dart';
import 'package:eventie/organizer/bottom_nav.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/role_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey            = GlobalKey<FormState>();

  bool _acceptTerms  = false;
  bool _isLoading    = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Sign in

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    // Simulate async auth — swap for Firebase later
    await Future.delayed(const Duration(milliseconds: 800));

    // Read saved role from SharedPreferences via provider
    // (already loaded in RoleNotifier._loadSavedRole on app start)
    final role = ref.read(roleProvider);

    setState(() => _isLoading = false);

    if (!mounted) return;
    _routeByRole(role);
  }

  // Route after sign in

  void _routeByRole(String? role) {
    final destination = role == 'organizer'
        ? const BottomNav()
        : const NavigationMenu(); // default to customer for null or 'customer'

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
          (route) => false, // clears the entire back stack
    );
  }

  // Validators

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    return regex.hasMatch(v.trim()) ? null : 'Enter a valid email';
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Password is required';
    return v.length < 6 ? 'Password must be at least 6 characters' : null;
  }


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Role set from welcome screen (null if coming from Login button)
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
                    Image.asset('assets/icons/applogo.png', scale: 8),

                    Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 8),

                    // ── Role indicator
                    // Only shown when coming from a welcome screen card
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
                              'Continuing as ${selectedRole[0].toUpperCase()}${selectedRole.substring(1)}',
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

                    // ── Email
                    LoginTextField(
                      hintText: 'Email',
                      icon: Icons.email_rounded,
                      controller: _emailController,
                      validator: _emailValidator,
                    ),

                    const SizedBox(height: 20),

                    // ── Password
                    LoginTextField(
                      hintText: 'Password',
                      icon: Icons.lock_rounded,
                      isPassword: true,
                      controller: _passwordController,
                      validator: _passwordValidator,
                    ),

                    const SizedBox(height: 20),

                    // ── Error message
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 10),

                    // ── Remember me
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) =>
                              setState(() => _acceptTerms = value!),
                          activeColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'Remember me',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ── Sign in button
                    Button(
                      onPressed: _isLoading ? null : _signIn,
                      text: _isLoading ? 'Signing in...' : 'Sign In',
                      width: double.infinity,
                      height: 50,
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ── Or continue with
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                                color: Color(0xFFE0E0E0), thickness: 1)),
                        const SizedBox(width: 6),
                        const Text('or continue with'),
                        const SizedBox(width: 6),
                        const Expanded(
                            child: Divider(
                                color: Color(0xFFE0E0E0), thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // ── Google
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAAAAAA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/google.png', scale: 24),
                          const SizedBox(width: 16),
                          Text(
                            'Continue With Google',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ── Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Sign Up',
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