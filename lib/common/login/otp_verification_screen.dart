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
            Text(
              "Code has been sent to your email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 40),

            // Pin Code Field Section
            PinCodeTextField(
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              onCompleted: (pin) => print('PIN: $pin'),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 58,
                fieldWidth: 72,
                activeFillColor: primaryColor,
                selectedFillColor: primaryColor,
                inactiveFillColor: primaryColor.withOpacity(0.15),
                inactiveColor: Colors.transparent,
                selectedColor: Colors.transparent,
                activeColor: Colors.transparent,
              ),
              enableActiveFill: true,
              textStyle: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 80),
            RichText(
              text: TextSpan(
                text: "Resend code in ",
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "55 s",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),
            const Spacer(),

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
