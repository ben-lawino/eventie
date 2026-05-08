import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String boldWord;
  final String titleEnd;
  final String description;
  final List<String> allImages;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.boldWord,
    required this.titleEnd,
    required this.description,
    required this.allImages,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final size = MediaQuery.of(context).size;

    // The other two images act as background stacked cards
    final backgroundImages = allImages.where((i) => i != image).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Stacked cards
          SizedBox(
            height: size.height * 0.45,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Left back card
                Transform.rotate(
                  angle: -0.18,
                  child: Transform.translate(
                    offset: const Offset(-30, 20),
                    child: _ImageCard(
                      image: backgroundImages[0],
                      size: size,
                      opacity: 0.7,
                    ),
                  ),
                ),

                // Right back card
                Transform.rotate(
                  angle: 0.18,
                  child: Transform.translate(
                    offset: const Offset(30, 20),
                    child: _ImageCard(
                      image: backgroundImages[1],
                      size: size,
                      opacity: 0.7,
                    ),
                  ),
                ),

                // Main front card
                _ImageCard(
                  image: image,
                  size: size,
                  opacity: 1.0,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Title
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
                height: 1.4,
              ),
              children: [
                TextSpan(text: '$title '),
                TextSpan(
                  text: '$boldWord\n',
                  style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor),
                ),
                TextSpan(text: titleEnd,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black26,
              height: 1.5,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final String image;
  final Size size;
  final double opacity;

  const _ImageCard({
    required this.image,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        height: size.height * 0.38,
        width: size.width * 0.62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}