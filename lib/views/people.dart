import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/services/encounters_service.dart';
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
  final EncountersService encounterService = EncountersService();
  List<Map<String, dynamic>> encounteredUsers = [];

  List<String> matchedUserIds = [];

  @override
  void initState() {
    super.initState();
    loadEncounteredUsers();
  }

  Future<void> loadEncounteredUsers() async {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> userIds = await encounterService.getEncounterUserIds(myUserId);

    List<Map<String, dynamic>> usersData = [];

    for (String userId in userIds) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        usersData.add({
          'id': userDoc.id,
          'name': userDoc['name'] ?? '',
          'photoUrl': userDoc['images'] != null && userDoc['images'].isNotEmpty
              ? userDoc['images'][0]
              : null,
        });
      }
    }

    setState(() {
      encounteredUsers = usersData;
    });
  }

  void goToProfile() {}

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
        body: Column(
          children: encounteredUsers.map((user) {
            return GestureDetector(
              onTap: () {
                // puedes abrir su perfil aquí si quieres
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user['photoUrl'] != null
                        ? NetworkImage(user['photoUrl'])
                        : AssetImage("assets/images/default_avatar.png")
                            as ImageProvider,
                  ),
                  SizedBox(height: 6),
                  Text(
                    user['name'] ?? '',
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }).toList(),
        ));
  }
}
