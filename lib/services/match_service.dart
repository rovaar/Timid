import 'package:cloud_firestore/cloud_firestore.dart';

class MatchService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerMatch(String userId1, String userId2) async {
    List<String> sortedIds = [userId1, userId2];
    sortedIds.sort();
    String matchId = sortedIds.join("_");

    await firestore.collection('matches').doc(matchId).set({
      'user1': sortedIds[0],
      'user2': sortedIds[1],
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<String>> getMatchedUserIds(String myUserId) async {
    QuerySnapshot matchesSnapshot = await FirebaseFirestore.instance
        .collection('matches')
        .where('user1', isEqualTo: myUserId)
        .get();

    QuerySnapshot matchesSnapshot2 = await FirebaseFirestore.instance
        .collection('matches')
        .where('user2', isEqualTo: myUserId)
        .get();

    List<String> matchedUserIds = [];

    for (var doc in matchesSnapshot.docs) {
      matchedUserIds.add(doc['user2']);
    }

    for (var doc in matchesSnapshot2.docs) {
      matchedUserIds.add(doc['user1']);
    }

    return matchedUserIds;
  }
}
