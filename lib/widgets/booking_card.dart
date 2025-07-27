import 'package:flutter/material.dart';

import '../common/constants/colors.dart';

class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String location;
  final VoidCallback? onCancelBooking;
  final VoidCallback? onViewTicket;
  final bool isBooked;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    this.onCancelBooking,
    this.onViewTicket,
    this.isBooked = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // Date
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Location with icon
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
              height: 20,
              //indent: 16,
              //endIndent: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancelBooking,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      minimumSize: const Size(0, 32),
                    ),
                    child: Text(
                        'Cancel Booking',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.primary,)
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onViewTicket,
                    style:  ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(0, 34)),
                      backgroundColor: WidgetStateProperty.all(AppColors.primary),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    child: Text(
                        'View E-Ticket',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
