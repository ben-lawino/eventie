import 'dart:convert';
import 'package:eventie/customer/providers/ticket_provider.dart';
import 'package:eventie/customer/screens/ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/dummy_data.dart';
import '../../../widgets/button.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:intl/intl.dart';
import '../../providers/booking_provider.dart';

class ETicketScreen extends ConsumerWidget {
  final BookingModel booking;

  const ETicketScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final event = dummyEvents.firstWhere((e) => e.id == booking.eventId);
    final ticketState = ref.watch(ticketProvider);
    final ticketNotifier = ref.read(ticketProvider.notifier);

    // Show snackbar when state changes
    ref.listen(ticketProvider, (_, next) {
      if (next.downloadStatus == DownloadStatus.success ||
          next.downloadStatus == DownloadStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? ''),
            behavior: SnackBarBehavior.floating,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: next.downloadStatus == DownloadStatus.success
                ? Colors.green
                : Colors.red,
          ),
        );
        ticketNotifier.reset(); // back to idle
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'E-Ticket',
        backDestination: const TicketPage(),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Screenshot(
              controller: ticketNotifier.screenshotController,
              child: _TicketCard(bookingId: booking.id, event: event),
            ),
            const SizedBox(height: 24),
            Button(
              onPressed:
              ticketState.downloadStatus == DownloadStatus.downloading
                  ? null
                  : () => ticketNotifier.downloadTicket(booking.id),
              text: ticketState.downloadStatus == DownloadStatus.downloading
                  ? 'Saving...'
                  : 'Download Ticket',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends ConsumerWidget {
  final String bookingId;
  final dynamic event;

  const _TicketCard({
    required this.bookingId,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingProvider);

    final booking = bookings.where((b) => b.id == bookingId).isNotEmpty
        ? bookings.firstWhere((b) => b.id == bookingId)
        : null;

    if (booking == null) {
      return const Center(child: Text('Booking not found'));
    }

    final qrData = jsonEncode({
      "bookingId": booking.id,
      "name": booking.fullName,
      "email": booking.email,
      "ticketId": booking.ticketId,
      "quantity": booking.quantity,
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // QR Code
          Padding(
            padding: const EdgeInsets.all(32),
            child: SizedBox(
              width: 220,
              height: 220,
              child: PrettyQrView.data(
                data: qrData, // ✅ FIXED (uses JSON)
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Divider
          const _DashedDivider(),

          // Event Details
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailRow(label: 'Event', value: event.title),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Date and Hour',
                  value: DateFormat('EEE, MMM d · HH:mm')
                      .format(event.eventDate),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Event Location',
                  value: event.location,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left notch
        Transform.translate(
          offset: const Offset(-16, 0),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Dashed line
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              const dashWidth = 6.0;
              const dashSpace = 4.0;
              final count =
              (constraints.maxWidth / (dashWidth + dashSpace)).floor();

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  count,
                      (_) => Container(
                    width: dashWidth,
                    height: 1.5,
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
          ),
        ),

        // Right notch
        Transform.translate(
          offset: const Offset(16, 0),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}