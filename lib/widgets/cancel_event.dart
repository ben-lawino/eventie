import 'package:eventie/customer/screens/mini_screens/cancel_reason.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

import '../common/constants/colors.dart';

class CancelEvent extends StatefulWidget {
  final String bookingId;
  const CancelEvent({super.key,required this.bookingId});

  @override
  State<CancelEvent> createState() => _CancelEventState();
}

class _CancelEventState extends State<CancelEvent> {
 
  
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(
                'Cancel Booking',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey[400], thickness: 1, height: 20),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to cancel \n this event?',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Only 90% of funds will be refunded \n according to our policy',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.textSecondary),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: primaryColor.withOpacity(0.15),
                      text: "No, Don’t cancel",
                      textColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Button(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CancelReason(
                              bookingId: widget.bookingId,
                            ),
                          ),
                        );
                      },
                      text: "Yes, Cancel",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
