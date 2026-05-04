import 'package:eventie/customer/providers/booking_provider.dart';
import 'package:eventie/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelReason extends ConsumerStatefulWidget {
  final String bookingId;

  const CancelReason({super.key, required this.bookingId});

  @override
  ConsumerState<CancelReason> createState() => _CancelReasonState();
}

class _CancelReasonState extends ConsumerState<CancelReason> {
  final List<String> reasons = [
    "Scheduling conflict with another event",
    "I am unwell and unable to attend",
    "An urgent matter has arisen",
    "I am unable to arrange transportation",
    "I have no one to attend with",
    "I intend to attend a different event",
    "I no longer wish to attend",
    "Others",
  ];

  String? selectedReason;
  final TextEditingController otherReasonController = TextEditingController();

  @override
  void dispose() {
    otherReasonController.dispose();
    super.dispose();
  }

  bool get isValid {
    if (selectedReason == null) return false;
    if (selectedReason == "Others") {
      return otherReasonController.text.trim().isNotEmpty;
    }
    return true;
  }

  void _onSubmitCancellation() {
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a valid reason')),
      );
      return;
    }

    final String reason = selectedReason == "Others"
        ? otherReasonController.text.trim()
        : selectedReason!;

    // Update provider FIRST
    ref.read(bookingProvider.notifier).cancelBooking(
      widget.bookingId,
      reason,
    );

    // Close bottom sheet BEFORE dialog
    Navigator.of(context).pop();

    // Show success dialog
    Future.delayed(const Duration(milliseconds: 200), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
            contentPadding: const EdgeInsets.only(
              top: 30,
              left: 40,
              right: 40,
              bottom: 25,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'You have successfully cancelled the event! 90% of the funds will be returned to you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                Button(
                  width: double.infinity,
                  onPressed: () {
                    Navigator.of(context).pop(); // close dialog
                  },
                  text: 'OK',
                ),
              ],
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(),
        title: Text(
          'Cancel Booking',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Please select reason for cancellation:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: reasons.length,
              itemBuilder: (context, index) {
                final reason = reasons[index];

                return RadioListTile<String>(
                  fillColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    reason,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  value: reason,
                  groupValue: selectedReason,
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value;
                      if (value != "Others") {
                        otherReasonController.clear();
                      }
                    });
                  },
                );
              },
            ),
          ),

          if (selectedReason == "Others")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: otherReasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Other reason...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Button(
              onPressed: isValid ? _onSubmitCancellation : null,
              width: double.infinity,
              text: 'Cancel Booking',
            ),
          ),
        ],
      ),
    );
  }
}