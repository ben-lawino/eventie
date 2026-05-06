import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/wallet_model.dart';
import '../organizer/providers/wallet_provider.dart';
import 'button.dart';

class WithdrawSheet extends ConsumerStatefulWidget {
  const WithdrawSheet({super.key});

  @override
  ConsumerState<WithdrawSheet> createState() => _WithdrawSheetState();
}

class _WithdrawSheetState extends ConsumerState<WithdrawSheet> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(walletProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Withdraw Funds", style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold
          )),
          const SizedBox(height: 12),

          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter amount",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          Button(
            width: double.infinity,
            text: wallet.status == WalletStatus.processing
                ? "Processing..."
                : "Confirm Withdrawal",
            onPressed: wallet.status == WalletStatus.processing
                ? null
                : () {
              final amount =
                  double.tryParse(controller.text.trim()) ?? 0;

              ref
                  .read(walletProvider.notifier)
                  .withdraw(amount);

              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}