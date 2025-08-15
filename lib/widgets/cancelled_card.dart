import 'package:flutter/material.dart';
import '../common/constants/colors.dart';

class CancelledCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String location;
  final VoidCallback? onCancelBooking;
  final bool isBooked;

  const CancelledCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    this.onCancelBooking,
    this.isBooked = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
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
                            .copyWith(fontWeight: FontWeight.bold,
                            fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 10),

                      // Date
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location with icon
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 15,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  location,
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.red
                                )
                            ),
                            child:Center(
                              child: Text(
                                'Cancelled',
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    fontSize: 8
                                ),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}