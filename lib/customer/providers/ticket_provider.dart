import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

enum DownloadStatus { idle, downloading, success, error }

class TicketState {
  final DownloadStatus downloadStatus;
  final String? message;

  const TicketState({
    this.downloadStatus = DownloadStatus.idle,
    this.message,
  });

  TicketState copyWith({
    DownloadStatus? downloadStatus,
    String? message,
  }) {
    return TicketState(
      downloadStatus: downloadStatus ?? this.downloadStatus,
      message: message ?? this.message,
    );
  }
}

class TicketNotifier extends StateNotifier<TicketState> {
  final ScreenshotController screenshotController = ScreenshotController();

  TicketNotifier() : super(const TicketState());

  Future<void> downloadTicket(String bookingId) async {
    // Android needs permission, iOS doesn't
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        state = state.copyWith(
          downloadStatus: DownloadStatus.error,
          message: 'Storage permission denied',
        );
        return;
      }
    }

    state = state.copyWith(downloadStatus: DownloadStatus.downloading);

    try {
      final imageBytes = await screenshotController.capture(pixelRatio: 3.0);

      if (imageBytes == null) {
        state = state.copyWith(
          downloadStatus: DownloadStatus.error,
          message: 'Failed to capture ticket',
        );
        return;
      }

      final result = await ImageGallerySaver.saveImage(
        imageBytes,
        name: 'ticket_$bookingId',
      );

      if (result['isSuccess']) {
        state = state.copyWith(
          downloadStatus: DownloadStatus.success,
          message: 'Ticket saved to gallery!',
        );
      } else {
        state = state.copyWith(
          downloadStatus: DownloadStatus.error,
          message: 'Failed to save ticket',
        );
      }
    } catch (e) {
      state = state.copyWith(
        downloadStatus: DownloadStatus.error,
        message: 'Download failed: $e',
      );
    }
  }

  // Reset state back to idle after snackbar is shown
  void reset() => state = const TicketState();
}

final ticketProvider =
StateNotifierProvider<TicketNotifier, TicketState>(
      (ref) => TicketNotifier(),
);