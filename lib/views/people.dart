import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/register/initialscreen.dart';
import 'package:timid/views/user_profile/profileImages.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => PeopleScreenState();
}

class PeopleScreenState extends State<PeopleScreen> {
  RegisterProfile registerProfile = RegisterProfile();
  List<File?> images = List.generate(30, (_) => null);
  List<String> imageUrls = List.generate(30, (_) => '');
  String profileImageUrl = '';

  Future<void> loadUserImages() async {
    List<String> urls = await registerProfile.getUserImages();
    setState(() {
      profileImageUrl = urls.isNotEmpty ? urls[0] : '';
    });
  }

  void goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileIamgesScreen()),
    ).then((_) => loadUserImages());
  }

  @override
  void initState() {
    super.initState();
    loadUserImages();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Initialscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "People",
        icon: Icons.logout,
        onPressed: logout,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: 800,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: List.generate(30, (index) {
                return GestureDetector(
                  onTap: goToProfile,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: profileImageUrl.isNotEmpty
                        ? NetworkImage(profileImageUrl)
                        : AssetImage("assets/images/default_avatar.png")
                            as ImageProvider,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
