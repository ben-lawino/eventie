import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/constants/colors.dart';
import '../../../data/dummy_data.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary({super.key});

  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  void _onConfirmPayment() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          contentPadding: EdgeInsets.only(
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
              SizedBox(height: 24),

              // Success title
              Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              // Success message
              Text(
                'You have successfully placed an order  for Nairobi Food & Music Festival.Enjoy the event!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),

              SizedBox(height: 24),

              Button(
                width: double.infinity,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'view E-ticket',
              ),
              SizedBox(height: 15),
              Button(
                width:double.infinity,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.primaryContainer,
                text: 'Cancel',
                textColor: AppColors.badge,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = dummyEvents[0];
    final formattedDate = DateFormat('EEE, MMM d, HH:mm').format(event.date);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Payments',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            PaymentCard(
              imageUrl: event.imageUrl,
              title: event.title,
              date: formattedDate,
              location: event.location,
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Full Name',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Ben lawino',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          '+254 700628088',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'lawinwes@gmail.com',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  spacing: 20,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 Ticket(Economy)',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Ksh.750',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey[400], thickness: 1, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Ksh.750',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Button(
                onPressed: _onConfirmPayment,
                text: 'Confirm and Pay',
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
