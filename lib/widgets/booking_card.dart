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
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    this.onCancelBooking,
    this.onViewTicket,
    this.isBooked = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                Spacer(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6), // slightly more space for better visual balance

                      // Date
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4), // give more room above location

                      // Location with icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center, // ensure vertical alignment
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14, // slightly larger for better visibility
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4), // consistent spacing
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]
            ),
          )
        ]
      )
    );
  }
}