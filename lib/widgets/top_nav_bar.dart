import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;

  const TopNavBar({super.key, required this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(text),
      actions: icon != null
          ? [
              IconButton(
                icon: Icon(icon),
                onPressed: onPressed,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
