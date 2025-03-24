import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/user_profile/profileImages.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RegisterProfile registerProfile = RegisterProfile();
  TextEditingController descriptionController = TextEditingController();
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    loadUserImages();
  }

  Future<void> loadUserImages() async {
    List<String> urls = await registerProfile.getUserImages();
    setState(() {
      profileImageUrl = urls[0];
    });
  }

  void goToChangeProfilePicture() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileIamgesScreen()),
    ).then((_) => loadUserImages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Perfil")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto de perfil con el botón de edición
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : AssetImage("assets/default_avatar.png")
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: goToChangeProfilePicture,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20,
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Campo de descripción
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),

            // Botón para guardar cambios
          ],
        ),
      ),
    );
  }
}
