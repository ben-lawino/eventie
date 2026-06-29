import 'package:eventie/common/auth/screens/signin.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/login_text_field.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreateNewPassword() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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

              // Success title
              const Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              // Success message
              Text(
                'You\'re all set! You’ll be redirected to the login page in a few seconds.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              //loader
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Create New Password',
        backDestination: SignInScreen(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Image.asset('assets/images/newpassword.png'),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Create Your New Password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 20),
                  LoginTextField(
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                    isPassword: true,
                    controller: _passwordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password is required';
                      if (v.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  LoginTextField(
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Please confirm your password';
                      if (v != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Button(
                    width: double.infinity,
                    onPressed: _onCreateNewPassword,
                    text: 'Continue',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
