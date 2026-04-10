import 'package:eventie/data/models/booking_model.dart';
import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:eventie/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../data/dummy_data.dart';
import '../../providers/booking_provider.dart'; // temporary for event lookup

class ReviewSummary extends ConsumerStatefulWidget {
  const ReviewSummary({super.key});

  @override
  ConsumerState<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends ConsumerState<ReviewSummary> {
  bool _isLoading = false;

  Future<void> _payWithMpesa() async {
    await Future.delayed(const Duration(seconds: 2));
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
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
              Icon(Icons.check_circle,
                  size: 80, color: Theme.of(context).colorScheme.primary),
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
                onPressed: () => Navigator.pop(context),
                text: 'Close',
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// bookings from provider
    final bookings = ref.watch(bookingProvider);

    final booking = bookings.last;

    ///  map event (replace later with DB)
    final event = dummyEvents.firstWhere(
          (e) => e.id == booking.eventId,
    );

    final formattedDate =
    DateFormat('EEE, MMM d, HH:mm').format(event.eventDate);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Review & Payment',
        onBackPressed: ()=>Navigator.pop(context),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Button(
          onPressed: () {},
          text: _isLoading ? 'Processing...' : 'Confirm & Pay',
          width: double.infinity,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// EVENT CARD
                PaymentCard(
                  imageUrl:
                  event.imageUrl ?? 'https://via.placeholder.com/150',
                  title: event.title,
                  date: formattedDate,
                  location: event.location,
                ),
            
                const SizedBox(height: 20),
            
                /// USER INFO
                _buildInfoCard(),
            
                /// PRICE
                _buildPriceCard(booking),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildInfoCard() {
    final bookings = ref.watch(bookingProvider);
    final booking = bookings.last;


    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Column(
        children: [
          _InfoRow(label: 'Full Name', value: booking.fullName ),
          _InfoRow(label: 'Phone', value: booking.phone),
          _InfoRow(label: 'Email', value: booking.email),
        ],
      ),
    );
  }

  Widget _buildPriceCard(booking) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: _boxStyle(),
      child: Column(
        children: [
          _InfoRow(
            label: '${booking.quantity} Ticket',
            value: 'Ksh.${booking.totalPrice}',
          ),
          const Divider(),
          _InfoRow(
            label: 'Total',
            value: 'Ksh.${booking.totalPrice}',
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
        )
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