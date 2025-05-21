import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/services/encounters_service.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/register/initialscreen.dart';
import 'package:timid/widgets/top_nav_bar.dart';
import 'package:timid/services/image_service.dart';

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
          'images': userDoc['images'] ?? [],
        });
      }
    }

    setState(() {
      encounteredUsers = usersData;
    });
  }

  void showUserProfileModal(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        List<dynamic> images = user['images'] ?? [];
        if (images.isEmpty && user['photoUrl'] != null) {
          images = [user['photoUrl']];
        }

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 650,
            width: 300,
            child: Column(
              children: [
                // Botones de acción arriba
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          // Acción para cancelar encounter
                          await encounterService.deleteEncounter(user['id']);
                          Navigator.of(context).pop();
                          await loadEncounteredUsers();
                        },
                      ),
                      Text(
                        user['name'] ?? 'No name',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.green),
                        onPressed: () async {
                          // Acción para hacer match
                          await encounterService.markAsMatched(user['id']);
                          Navigator.of(context).pop();
                          await loadEncounteredUsers();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Galería de imágenes vertical
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          text: "Persones",
          icon: Icons.logout,
          onPressed: logout,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: encounteredUsers.isEmpty
              ? const Center(child: Text("Encara no has trobat cap usuari."))
              : GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: encounteredUsers.map((user) {
                    return GestureDetector(
                      onTap: () {
                        showUserProfileModal(user);
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                ImageService.getUserAvatar(user['images']),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            user['name'] ?? '',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ));
  }
}
