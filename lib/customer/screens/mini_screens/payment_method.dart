import 'package:eventie/customer/screens/mini_screens/review_summary.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/models/booking_model.dart';

class PaymentMethodScreen extends StatefulWidget {
  final BookingModel booking;
  final double amount;
  final String phone;

  const PaymentMethodScreen({
    super.key,
    required this.amount,
    required this.phone,
    required this.booking,
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

  bool _isValidMpesaNumber(String number) {
    final cleaned = number.replaceAll(' ', '');

    // local format: 07XX or 01XX (10 digits)
    final localFormat = RegExp(r'^0[17]\d{8}$');

    // international format: +2547XX or +2541XX
    final intlFormat = RegExp(r'^\+2547\d{8}$|^\+2541\d{8}$');

    return localFormat.hasMatch(cleaned) || intlFormat.hasMatch(cleaned);
  }

  @override
  Widget build(BuildContext context) {
    final isMpesa = _selectedPayment == 'M-pesa';

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: 'Payment Method',
        onBackPressed: () => Navigator.pop(context),
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

                      // M-Pesa option
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

                      // Phone field shown only when M-pesa is selected
                      if (isMpesa) ...[
                        Text(
                          'Enter M-Pesa phone number',
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
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            decoration: const InputDecoration(
                              hintText: 'e.g. 0712345678',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Safaricom numbers only (07XX or 01XX)',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.45),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Continue button
              Button(
                onPressed: () {
                  if (_selectedPayment == 'M-pesa') {
                    if (_phoneController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter phone number")),
                      );
                      return;
                    }

                    if (!_isValidMpesaNumber(_phoneController.text.trim())) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enter a valid Safaricom number"),
                        ),
                      );
                      return;
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewSummary(),
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
          color: isSelected ? primaryColor.withOpacity(0.15) : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
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
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}