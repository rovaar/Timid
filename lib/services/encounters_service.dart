import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EncountersService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> registerEncounter(String userId1, String userId2) async {
    List<String> sortedIds = [userId1, userId2]..sort();
    String encounterId = sortedIds.join("_");

    await firestore.collection('encounters').doc(encounterId).set({
      'user1': sortedIds[0],
      'user2': sortedIds[1],
      'matched': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<String>> getEncounterUserIds(String myUserId) async {
    final query = await firestore
        .collection('encounters')
        .where('matched', isEqualTo: false)
        .get();

    List<String> encounteredUserIds = [];

    for (var doc in query.docs) {
      final user1 = doc['user1'];
      final user2 = doc['user2'];

      if (user1 == myUserId) {
        encounteredUserIds.add(user2);
      } else if (user2 == myUserId) {
        encounteredUserIds.add(user1);
      }
    }

    return encounteredUserIds;
  }

  Future<List<String>> getMatchedUserIds(String myUserId) async {
    final query = await firestore
        .collection('encounters')
        .where('matched', isEqualTo: true)
        .get();

    List<String> matchedUserIds = [];

    for (var doc in query.docs) {
      final user1 = doc['user1'];
      final user2 = doc['user2'];

      if (user1 == myUserId) {
        matchedUserIds.add(user2);
      } else if (user2 == myUserId) {
        matchedUserIds.add(user1);
      }
    }

    return matchedUserIds;
  }

  Future<void> markAsMatched(String otherUserId) async {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> sortedIds = [myUserId, otherUserId]..sort();
    String encounterId = sortedIds.join("_");

    await FirebaseFirestore.instance
        .collection('encounters')
        .doc(encounterId)
        .update({'matched': true});
  }

  Future<void> deleteEncounter(String otherUserId) async {
    final myUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> sortedIds = [myUserId, otherUserId]..sort();
    String encounterId = sortedIds.join("_");

    await FirebaseFirestore.instance
        .collection('encounters')
        .doc(encounterId)
        .delete();
  }
}
