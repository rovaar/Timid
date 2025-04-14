import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/services/chat_service.dart';
import 'package:timid/widgets/chat_bubble.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatScreen({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserID, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "Chats",
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessages(
          widget.receiverUserID, firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data == null) return const SizedBox();

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(hintText: 'Email'),
            obscureText: false,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ),
        )
      ],
    );
  }
}
