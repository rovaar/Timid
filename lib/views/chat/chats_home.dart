import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timid/services/chat_service.dart';
import 'package:timid/views/chat/chat.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class ChatsHomeScreen extends StatefulWidget {
  const ChatsHomeScreen({super.key});

  @override
  State<ChatsHomeScreen> createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatSerivece chatService = ChatSerivece();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "Chats",
      ),
      body: Column(
        children: [
          Expanded(
            child: UserList(),
          ),
        ],
      ),
    );
  }

  Widget UserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data == null) return const SizedBox();

    if (auth.currentUser!.email != data['email']) {
      return ListTile(
          title: Text(data['email']),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                        receiverUserEmail: data['email'],
                        receiverUserID: data['uid'])));
          });
    } else {
      return Container();
    }
  }
}
