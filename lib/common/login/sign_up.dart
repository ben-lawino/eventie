import 'package:eventie/common/login/signin.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/login_text_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Image.asset('assets/icons/applogo.png', scale: 8),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  LoginTextField(hintText: 'Email', icon: Icons.email_rounded),
                  SizedBox(height: 20),
                  LoginTextField(
                    hintText: 'Password',
                    icon: Icons.lock_rounded,
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  LoginTextField(
                    hintText: 'Confirm Password',
                    icon: Icons.lock_rounded,
                    isPassword: true,
                  ),

                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value!;
                          });
                        },
                        activeColor: const Color(0xFF5B52D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                              children: const [
                                TextSpan(text: 'I accept the Eventie '),
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: Color(0xFF5B52D5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: ', '),
                                TextSpan(
                                  text: 'Community Guidelines',
                                  style: TextStyle(
                                    color: Color(0xFF5B52D5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: ', and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xFF5B52D5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
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
                  SizedBox(height: 25),
                  Button(
                    onPressed: () {

                    },
                    text: 'Sign Up',
                    width: double.infinity,
                    height: 50,
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                      ),
                      SizedBox(width: 6),
                      Text('or continue with'),
                      SizedBox(width: 6),
                      Expanded(
                        child: Divider(color: Color(0xFFE0E0E0), thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset('assets/icons/google.png', scale: 24),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
    );
  }
}
