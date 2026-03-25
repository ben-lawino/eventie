import 'package:eventie/common/login/signin.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        backDestination: SignInScreen(),
        title: 'OTP Code Verification',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              "Code has been send to your email",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),

            // Pin Code Field Section
            PinInput(
              length: 4,
              keyboardType: TextInputType.number,
              builder: (context, cells) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cells.map((cell) {
                    return Container(
                      width: 72,
                      height: 58,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: cell.isFocused
                            ? primaryColor
                            : primaryColor.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Text(
                          cell.character ?? '',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              onCompleted: (pin) => print('PIN: $pin'),
            ),

            const SizedBox(height: 80),
            RichText(
              text: const TextSpan(
                text: "Resend code in ",
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: "55 s",
                    style: TextStyle(
                      color: Color(0xFF7B61FF), // Purple timer color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Pushes the button to the bottom

            // Verify Button
            Button(
              width: double.infinity,
              onPressed: () {},
              text: 'Verify',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
