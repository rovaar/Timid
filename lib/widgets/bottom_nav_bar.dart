import 'package:flutter/material.dart';
import 'package:timid/theme/global_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.primary,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Persones'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Xats'),
      ],
    );
  }
}
