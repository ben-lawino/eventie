enum WalletStatus { idle, processing, success, error }

class WalletModel {
  final double availableBalance;
  final double pendingPayout;
  final WalletStatus status;
  final String? message;

  WalletModel({
    required this.availableBalance,
    required this.pendingPayout,
    this.status = WalletStatus.idle,
    this.message,
  });

  WalletModel copyWith({
    double? availableBalance,
    double? pendingPayout,
    WalletStatus? status,
    String? message,
  }) {
    return WalletModel(
      availableBalance: availableBalance ?? this.availableBalance,
      pendingPayout: pendingPayout ?? this.pendingPayout,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}