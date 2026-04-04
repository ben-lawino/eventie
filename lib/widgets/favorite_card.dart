import 'package:flutter/material.dart';
import '../common/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../customer/providers/favorites_provider.dart';

class FavoriteCard extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String location;
  final String eventId;

  final bool isBooked;
  final VoidCallback onTap;

  const FavoriteCard({
    required this.eventId,
    required this.onTap,
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    this.isBooked = true,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    final isFav = ref.watch(favoritesProvider).contains(eventId);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: 120,
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
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
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
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location with icon
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 15,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              location,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              ref.read(favoritesProvider.notifier).remove(eventId);
                            },
                            icon: Icon(
                              Icons.favorite_rounded,
                              size: 20,
                              color: ref.watch(favoritesProvider).contains(eventId)
                                  ? primaryColor
                                  : primaryColor,
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
