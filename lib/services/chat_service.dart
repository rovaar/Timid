import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/model/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    //construct chat toom id from current user id and reciver id
    String chatRoomId = getChatRoomId(currentUserId, receiverId);

    //add new message to database
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    String chatRoomId = getChatRoomId(userId, otherUserId);

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  String getChatRoomId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join("_");
  }
}
