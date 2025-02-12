import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timid/views/login.dart';
import 'package:timid/views/people.dart';
import 'package:timid/views/profile.dart';
import 'package:timid/views/chats.dart';
import 'package:timid/widgets/bottom_nav_bar.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int selectedIndex = 1;

  final List<Widget> screens = [
    const ProfileScreen(),
    const PeopleScreen(),
    const ChatsScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
