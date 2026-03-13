import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? backDestination;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.backDestination,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      leading: IconButton(
        onPressed: onBackPressed ??
                () {
              if (backDestination != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => backDestination!),
                );
              } else {
                Navigator.pop(context);
              }
            },
        icon: const Icon(Icons.arrow_back_rounded),
        color: Colors.grey[700],
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}