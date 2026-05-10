import 'package:collection/collection.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/dummy_data.dart';
import '../../../data/models/booking_model.dart';
import '../../providers/booking_provider.dart';
import 'e_ticket_screen.dart';

class ReviewSummary extends ConsumerStatefulWidget {
  const ReviewSummary({super.key});

  @override
  ConsumerState<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends ConsumerState<ReviewSummary> {
  bool _isLoading = false;

  Future<void> _payWithMpesa() async {
    final bookings = ref.read(bookingProvider);
    final booking = bookings.last;

    // TODO: trigger real M-Pesa STK push here
    await Future.delayed(const Duration(seconds: 2));

    ref.read(bookingProvider.notifier).updateBooking(
      booking.id,
      booking.copyWith(status: 'paid'),
    );

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    final bookings = ref.read(bookingProvider);
    final booking = bookings.last;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              const Text(
                'Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Payment completed successfully.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Button(
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ETicketScreen(booking: booking),
                    ),
                  );
                },
                text: 'View My Ticket',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingProvider);

    // guard empty state
    if (bookings.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No booking found')),
      );
    }

    final booking = bookings.last;

    // TODO: replace with Firestore lookup
    final event = dummyEvents.firstWhereOrNull((e) => e.id == booking.eventId);

    if (event == null) {
      return const Scaffold(
        body: Center(child: Text('Event not found')),
      );
    }

    final formattedDate =
    DateFormat('EEE, MMM d, HH:mm').format(event.eventDate);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Review & Payment',
        onBackPressed: () => Navigator.pop(context),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Button(
          onPressed: _isLoading
              ? null
              : () async {
            setState(() => _isLoading = true);
            await _payWithMpesa();
            setState(() => _isLoading = false);
          },
          text: _isLoading ? 'Processing...' : 'Confirm & Pay',
          width: double.infinity,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Event card
              PaymentCard(
                imageUrl: event.imageUrl ?? 'https://via.placeholder.com/150',
                title: event.title,
                date: formattedDate,
                location: event.location,
              ),
              const SizedBox(height: 20),

              // User info
              _buildInfoCard(booking),

              // Price
              _buildPriceCard(booking),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BookingModel booking) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Column(
        children: [
          _InfoRow(label: 'Full Name', value: booking.fullName),
          _InfoRow(label: 'Phone', value: booking.phone),
          _InfoRow(label: 'Email', value: booking.email),
        ],
      ),
    );
  }

  Widget _buildPriceCard(BookingModel booking) {
    final formatted = NumberFormat('#,##0').format(booking.totalPrice);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Column(
        children: [
          _InfoRow(
            label: '${booking.quantity} Ticket(s)',
            value: 'Ksh. $formatted',
          ),
          const Divider(),
          _InfoRow(
            label: 'Total',
            value: 'Ksh. $formatted',
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}