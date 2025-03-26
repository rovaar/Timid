import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterProfile {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

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

  //GET USER

  User? getCurrentUser() {
    return auth.currentUser;
  }

  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }

  String? getCurrentUserEmail() {
    return auth.currentUser?.email;
  }

  Future<String?> uploadProfileImage(File imageFile) async {
    User? user = auth.currentUser;

    if (user != null) {
      try {
        String filePath =
            'users/${user.uid}/images/${DateTime.now().millisecondsSinceEpoch}.jpg';

        UploadTask uploadTask = storage.ref(filePath).putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;

        String downloadURL = await snapshot.ref.getDownloadURL();
        return downloadURL;
      } catch (e) {
        print("Error al subir la imagen: $e");
        return null;
      }
    } else {
      print("No hay ningún usuario autenticado.");
      return null;
    }
  }

  Future<void> saveUserImages(List<String> imageUrls) async {
    User? user = auth.currentUser;

    if (user != null) {
      await firestore.collection('users').doc(user.uid).update({
        'images': FieldValue.arrayUnion(imageUrls),
      });
    }
  }

  Future<List<String>> getUserImages() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      return List<String>.from(userDoc["images"] ?? []);
    }
    return [];
  }

  Future<void> deleteProfileImage(int index) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentSnapshot userDoc = await userRef.get();

    if (userDoc.exists) {
      List<String> imageUrls = List<String>.from(userDoc["images"] ?? []);
      if (index < imageUrls.length) {
        String imageUrl = imageUrls[index];
        Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
        await ref.delete();
        imageUrls[index] = "";
        await userRef.update({"images": imageUrls});
      }
    }
  }
}
