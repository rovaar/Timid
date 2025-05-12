import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/services/chat_service.dart';
import 'package:timid/theme/global_colors.dart';
import 'package:timid/widgets/chat_bubble.dart';
import 'package:timid/services/image_service.dart';
import 'package:timid/services/encounters_service.dart';

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
  final EncountersService encounterService = EncountersService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map<String, dynamic>? user;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserID, messageController.text);
      messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    loadReceiverUserData();
  }

  Future<void> loadReceiverUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiverUserID)
        .get();

    if (doc.exists) {
      final data = doc.data();
      data!['id'] = doc.id;
      print("Datos del usuario receptor: $data");
      setState(() {
        user = data;
      });
    } else {
      print("No se encontró el documento del usuario receptor.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: AppColors.accent),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                if (user != null) ...[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        ImageService.getUserAvatar(user!['images']),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user!['name'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close,
                        size: 30, color: AppColors.accent),
                    onPressed: () async {
                      await encounterService.deleteEncounter(user!['id']);
                      Navigator.of(context).pop();
                      await loadReceiverUserData();
                    },
                  ),
                ] else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
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
          children: [ChatBubble(message: data['message'])],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Escriu un missatge',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 30,
          ),
        )
      ],
    );
  }
}
