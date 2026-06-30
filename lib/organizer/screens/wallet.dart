import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../data/models/wallet_model.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/withdraw_sheet.dart';
import '../bottom_nav.dart';
import '../providers/wallet_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Listen to wallet state changes
    ref.listen(walletProvider, (previous, next) {
      if (next.status == WalletStatus.processing ||
          next.status == WalletStatus.success ||
          next.status == WalletStatus.error) {

        // Prevent stacking snackbars
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            SnackBar(content: Center(child: Text(next.message ?? ""))),
          );

        // Reset state after success/error
        if (next.status != WalletStatus.processing) {
          ref.read(walletProvider.notifier).resetStatus();
        }
      }
    });

    final wallet = ref.watch(walletProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Wallet', backDestination: BottomNav()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
        child: Column(
          children: [
            _walletCard(
              context,
              title: 'Available Balance',
              amount: wallet.availableBalance,
              color: primaryColor,
            ),
            const SizedBox(height: 8),
            _walletCard(
              context,
              title: 'Pending Payout',
              amount: wallet.pendingPayout,
              color: primaryColor,
            ),
            const Divider(),
            const SizedBox(height: 10),

            Button(
              width: double.infinity,
              text: wallet.status == WalletStatus.processing
                  ? 'Processing...'
                  : 'Withdraw Funds',
              color: primaryColor,

              // Disable button while processing
              onPressed: wallet.status == WalletStatus.processing
                  ? null
                  : () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (_) => const WithdrawSheet(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _walletCard(
      BuildContext context, {
        required String title,
        required double amount,
        required Color color,
      }) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 18),
          ),

          // 💰 Better currency formatting
          Text(
            'Ksh ${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}