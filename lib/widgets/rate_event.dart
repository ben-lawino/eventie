import 'package:eventie/customer/screens/mini_screens/cancel_reason.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

class RateEvent extends StatefulWidget {
  const RateEvent({super.key});

  @override
  State<RateEvent> createState() => _CancelEventState();
}

class _CancelEventState extends State<RateEvent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            'Leave a Rating',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey[400], thickness: 1, height: 20),
          SizedBox(height: 10),
          Text(
            'How was your experience with \n Nairobi Food and Music Festival?',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          SizedBox(height: 15),
          Divider(color: Colors.grey[400], thickness: 1, height: 20),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                width: 180,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.primaryContainer,
                text: 'Maybe Later',
                textColor: Theme.of(context).colorScheme.primary,
              ),
              Button(
                width: 180,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CancelReason()),
                  );
                },
                text: 'Submit',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
