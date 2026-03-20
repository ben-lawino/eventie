import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../bottom_nav.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: CustomAppBar(title: 'Scan', backDestination: BottomNav()),
      body: Center(
        child: Column(
          children: [
            Text(
              'Scan Event Ticket',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 60),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.10),
                border: Border.all(color: primaryColor, width: 2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/scanner.png',
                scale: 6,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Align the QR code within the circle",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Or',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Button(width: 300, onPressed: () {}, text: 'Add Manually'),
          ],
        ),
      ),
    );
  }
}
