import 'package:flutter/material.dart';
import '../common/constants/colors.dart';
import '../customer/screens/details.dart';
import '../data/models/event_model.dart';

class GridCard extends StatelessWidget {
  final String imageUrl;
  final EventModel event;
  final String title;
  final String date;
  final String location;
  final VoidCallback? onFavorite;

  const GridCard({
    super.key,
    required this.event,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //final selectedEvent = dummyEvents.firstWhere((e) => e.id == dummyEvents[0].id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsScreen(event: event)),
        );
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.black.withOpacity(0.45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SizedBox(
          height: 220,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Image.network(
                  imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 6),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Date Row
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Location Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.place_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: const Color(0xFF757575)),
                          ),
                        ),
                        IconButton(
                          onPressed: onFavorite,
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
