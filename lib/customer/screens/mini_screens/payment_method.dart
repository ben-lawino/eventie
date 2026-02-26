import 'package:eventie/customer/screens/mini_screens/review_summary.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPayment = 'PayPal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Center(
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/scanner.png',
                  width: 25,
                  height: 25,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select the payment method you want to use.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // PayPal Option
                      _buildPaymentOption(
                        image: Image.asset(
                          'assets/icons/mpesa.png',
                          height: 40,
                          width: 40,
                        ),
                        label: 'M-pesa',
                        value: 'M-pesa',
                      ),
                      const SizedBox(height: 40),

                      // Google Pay Option
                      _buildPaymentOption(
                        image: Image.asset(
                          'assets/icons/google.png',
                          height: 40,
                          width: 40,
                        ),
                        label: 'Google Pay',
                        value: 'Google Pay',
                      ),
                      const SizedBox(height: 40),

                      // Apple Pay Option
                      _buildPaymentOption(
                        image: Image.asset(
                          'assets/icons/social.png',
                          height: 40,
                          width: 40,
                        ),
                        label: 'Paypal',
                        value: 'Paypal',
                      ),
                      const SizedBox(height: 30),

                      // Add New Card Button
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B52D5).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Add New Card',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5B52D5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Continue Button - Fixed at bottom
              Button(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewSummary()),
                  );
                },
                text: 'Continue',
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required Image image,
    required String label,
    required String value,
  }) {
    final bool isSelected = _selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              blurRadius: 8,
              offset: const Offset(0, -1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Payment Icon
            image,
            const SizedBox(width: 16),

            // Payment Label
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Radio Button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.deepViolet
                      : Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF5B52D5),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
