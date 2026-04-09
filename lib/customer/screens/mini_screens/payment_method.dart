import 'package:eventie/customer/screens/mini_screens/review_summary.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../../data/models/booking_model.dart';


class PaymentMethodScreen extends StatefulWidget {
  final BookingModel booking;
  final double amount;
  final String phone;
  const PaymentMethodScreen({super.key,
    required this.amount,
    required this.phone,
    required this.booking
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedPayment = 'M-pesa';

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMpesa = _selectedPayment == 'M-pesa';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Payments',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
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
                      const SizedBox(height: 30),

                      // M-Pesa Option
                      _buildPaymentOption(
                        image: Image.asset(
                          'assets/icons/mpesa.png',
                          height: 40,
                          width: 40,
                        ),
                        label: 'M-pesa',
                        value: 'M-pesa',
                      ),

                      const SizedBox(height: 24),

                      // 🔥 SHOW PHONE FIELD ONLY IF MPESA SELECTED
                      if (isMpesa) ...[
                        Text(
                          "Enter phone number",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'e.g. 07XXXXXXXX',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              //CONTINUE BUTTON
              Button(
                onPressed: () {
                  // VALIDATION
                  if (_selectedPayment == 'M-pesa' &&
                      _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter phone number"),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewSummary(
                      ),
                    ),
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
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.15)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            image,
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected
                  ? primaryColor
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}