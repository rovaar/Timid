import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timid/services/chat_service.dart';
import 'package:timid/services/encounters_service.dart';
import 'package:timid/views/chat/chat.dart';
import 'package:timid/widgets/top_nav_bar.dart';
import 'package:timid/services/image_service.dart';

class ChatsHomeScreen extends StatefulWidget {
  const ChatsHomeScreen({super.key});

  @override
  State<ChatsHomeScreen> createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final EncountersService encounterService = EncountersService();

  List<String> matchedUserIds = [];

  @override
  void initState() {
    super.initState();
    loadMatchedUsers();
  }

  Future<void> loadMatchedUsers() async {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> users = await encounterService.getMatchedUserIds(myUserId);
    setState(() {
      matchedUserIds = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "Chats",
      ),
      body: matchedUserIds.isEmpty
          ? const Center(child: Text("No tienes matches aún"))
          : StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Filtrar usuarios por match
                var matchedUsers = snapshot.data!.docs.where((doc) {
                  return matchedUserIds.contains(doc.id);
                }).toList();

                return ListView.builder(
                  itemCount: matchedUsers.length,
                  itemBuilder: (context, index) {
                    var userDoc = matchedUsers[index];
                    var user = userDoc.data() as Map<String, dynamic>;

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            ImageService.getUserAvatar(user['images']),
                      ),
                      title: Text(user['name'] ?? 'Sin nombre'),
                      subtitle: Text(user['email'] ?? ''),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              receiverUserEmail: user['email'],
                              receiverUserID: userDoc.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
