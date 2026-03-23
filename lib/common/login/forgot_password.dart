import 'package:eventie/common/login/signin.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/login_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backDestination: SignInScreen(),
        title: 'Forgot Password',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/forgotpass.png', scale: 6),
                Text(
                  'Enter your email below. We’ll send you a code to verify your identity.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                LoginTextField(hintText: 'email', icon: Icons.email_rounded),
                SizedBox(height: 170),
                Button(
                    width: double.infinity,
                    onPressed: () {},
                    text: 'Send Code'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
