import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/views/people.dart';
import 'package:timid/views/user_profile/profile.dart';
import 'package:timid/views/chat/chats_home.dart';
import 'package:timid/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const ProfileScreen(),
      const PeopleScreen(),
      ChatsHomeScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
