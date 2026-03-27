import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final bool value;

  const SettingTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Switch(
            value: value,
            onChanged: (val) {},
            activeThumbColor: Colors.white,
            activeTrackColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
