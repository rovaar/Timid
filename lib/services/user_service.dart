import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterProfile {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseFirestore storage = FirebaseFirestore.instance;

  Future<void> saveName(String name) async {
    User? user = auth.currentUser;

    if (user != null) {
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
      }, SetOptions(merge: true));
    } else {
      print("No hay ningún usuario autenticado.");
    }
  }

  Future<void> saveBirth(DateTime? birthDate) async {
    User? user = auth.currentUser;

    if (user != null) {
      await firestore.collection('users').doc(user.uid).set({
        'birthDate': Timestamp.fromDate(birthDate!),
      }, SetOptions(merge: true));
    } else {
      print("No hay ningún usuario autenticado.");
    }
  }

  Future<void> saveGender(String gender) async {
    User? user = auth.currentUser;

    if (user != null) {
      await firestore.collection('users').doc(user.uid).set({
        'gender': gender,
      }, SetOptions(merge: true));
    } else {
      print("No hay ningún usuario autenticado.");
    }
  }
}
