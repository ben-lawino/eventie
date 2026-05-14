import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
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
    // Android 12 and below needs storage permission
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          state = state.copyWith(
            downloadStatus: DownloadStatus.error,
            message: 'Storage permission denied',
          );
          return;
        }
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

      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        name: 'ticket_$bookingId',
      );

      final isSuccess = result['isSuccess'] == true;

      if (isSuccess) {
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

  // reset state back to idle after snackbar is shown
  void reset() => state = const TicketState();
}

final ticketProvider = StateNotifierProvider<TicketNotifier, TicketState>(
      (ref) => TicketNotifier(),
);