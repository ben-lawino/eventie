import 'package:eventie/organizer/bottom_nav.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNav()),
            );
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.grey[700],
        ),
        title: Text(
          'Wallet',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Balance',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                  Text(
                    'ksh.108,500',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(14),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pending Payout',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 18),
                  ),
                  Text(
                    'ksh.8,500',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Button(
              width: double.infinity,
              onPressed: () {},
              text: 'Withdraw Funds',
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
