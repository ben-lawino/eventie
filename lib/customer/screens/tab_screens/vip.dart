import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../mini_screens/book_event_detail.dart';

class Vip extends StatelessWidget {
  const Vip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Choose number of tickets',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    'assets/icons/minus.png',
                    scale: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  '1',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    'assets/icons/add.png',
                    scale: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            Spacer(),
            Button(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookEventDetail()),
                );
              },
              text: 'Continue - Ksh.1000',
              width: double.infinity,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
