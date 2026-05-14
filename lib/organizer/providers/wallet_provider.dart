import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/wallet_model.dart';

final walletProvider =
StateNotifierProvider<WalletNotifier, WalletModel>((ref) {
  return WalletNotifier();
});

class WalletNotifier extends StateNotifier<WalletModel> {
  WalletNotifier()
      : super(
    WalletModel(
      availableBalance: 108500,
      pendingPayout: 8500,
    ),
  );

  static const double minWithdraw = 100.0;

  double _round(double value) =>
      double.parse(value.toStringAsFixed(2));

  Future<void> withdraw(double amount) async {
    if (state.status == WalletStatus.processing) return;

    debugPrint("Withdraw requested: $amount");

    if (amount <= 0) {
      state = state.copyWith(
        status: WalletStatus.error,
        message: "Invalid amount",
      );
      return;
    }

    if (amount < minWithdraw) {
      state = state.copyWith(
        status: WalletStatus.error,
        message: "Minimum withdrawal is Ksh $minWithdraw",
      );
      return;
    }

    if (amount > state.availableBalance) {
      state = state.copyWith(
        status: WalletStatus.error,
        message: "Insufficient balance",
      );
      return;
    }

    state = state.copyWith(
      status: WalletStatus.processing,
      message: "Withdrawal processing...",
    );

    try {
      await Future.delayed(const Duration(seconds: 2));

      state = state.copyWith(
        availableBalance:
        _round(state.availableBalance - amount),
        pendingPayout:
        _round(state.pendingPayout + amount),
        status: WalletStatus.success,
        message: "Withdrawal request submitted",
      );
    } catch (e) {
      debugPrint("Withdraw error: $e");

      state = state.copyWith(
        status: WalletStatus.error,
        message: "Withdrawal failed. Try again.",
      );
    }
  }

  void resetStatus() {
    state = state.copyWith(
      status: WalletStatus.idle,
      message: null,
    );
  }
}