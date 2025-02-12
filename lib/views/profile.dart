import 'package:flutter/material.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(text: "Profile", icon: Icons.settings),
    );
  }
}
