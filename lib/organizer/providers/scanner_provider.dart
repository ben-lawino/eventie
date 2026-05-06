import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ScanStatus { idle, loading, success, failure }

class ScannerState {
  final ScanStatus status;
  final String? message;
  final String? lastScannedCode;

  const ScannerState({
    this.status = ScanStatus.idle,
    this.message,
    this.lastScannedCode,
  });

  ScannerState copyWith({
    ScanStatus? status,
    String? message,
    String? lastScannedCode,
  }) {
    return ScannerState(
      status: status ?? this.status,
      message: message ?? this.message,
      lastScannedCode: lastScannedCode ?? this.lastScannedCode,
    );
  }
}

class ScannerNotifier extends Notifier<ScannerState> {
  @override
  ScannerState build() {
    return const ScannerState();
  }

  Future<void> onBarcodeDetected(String code) async {
    if (state.status == ScanStatus.loading) return;
    if (code.isEmpty) return;

    await _validateTicket(code);
  }

  Future<void> validateManually(String ticketId) async {
    final code = ticketId.trim();
    if (code.isEmpty) return;

    await _validateTicket(code);
  }

  Future<void> _validateTicket(String code) async {
    state = state.copyWith(
      status: ScanStatus.loading,
      lastScannedCode: code,
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      final isValid = code.startsWith('TKT-');

      state = state.copyWith(
        status: isValid ? ScanStatus.success : ScanStatus.failure,
        message: isValid
            ? 'Ticket validated successfully!'
            : 'Invalid or already used ticket.',
      );
    } catch (_) {
      state = state.copyWith(
        status: ScanStatus.failure,
        message: 'Something went wrong. Please try again.',
      );
    }
  }

  void reset() {
    state = const ScannerState();
  }
}

final scannerProvider =
NotifierProvider<ScannerNotifier, ScannerState>(
    ScannerNotifier.new);