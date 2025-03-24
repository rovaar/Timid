import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/widgets/button_global.dart';

class ProfileIamgesScreen extends StatefulWidget {
  const ProfileIamgesScreen({super.key});

  @override
  State<ProfileIamgesScreen> createState() => _ProfileImagesScreenState();
}

class _ProfileImagesScreenState extends State<ProfileIamgesScreen> {
  final ImagePicker picker = ImagePicker();
  RegisterProfile registerProfile = RegisterProfile();
  List<File?> images = List.generate(6, (_) => null);
  List<String> imageUrls = List.generate(6, (_) => '');

  @override
  void initState() {
    super.initState();
    loadUserImages();
  }

  Future<void> loadUserImages() async {
    List<String> urls = await registerProfile.getUserImages();
    setState(() {
      for (int i = 0; i < urls.length && i < 6; i++) {
        imageUrls[i] = urls[i];
      }
    });
  }

  Future<void> pickImage(int index) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      setState(() {
        images[index] = imageFile;
        imageUrls[index] = '';
      });

      String? imageUrl = await registerProfile.uploadProfileImage(imageFile);
      if (imageUrl != null) {
        setState(() {
          imageUrls[index] = imageUrl;
        });
      }
    }
  }

  void removeImage(int index) {
    setState(() {
      images[index] = null;
      imageUrls[index] = '';
    });

    registerProfile.deleteProfileImage(index);
  }

  Future<void> goToNextPage() async {
    int selectedImagesCount = images.where((image) => image != null).length;

    if (selectedImagesCount < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Debes subir al menos 3 imágenes')),
      );
      return;
    }

    List<String> uploadedImageUrls = [];
    for (File? image in images) {
      if (image != null) {
        String? imageUrl = await registerProfile.uploadProfileImage(image);
        if (imageUrl != null) {
          uploadedImageUrls.add(imageUrl);
        }
      }
    }

    await registerProfile.saveUserImages(uploadedImageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selecciona entre 3 y 6 fotos para tu perfil:",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => pickImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: imageUrls[index].isNotEmpty
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          imageUrls[index],
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(Icons.cancel,
                                              color: Colors.red),
                                          onPressed: () => removeImage(index),
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: Icon(Icons.add_a_photo,
                                        size: 40, color: Colors.grey),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Botón de continuar
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ButtonGlobal(text: 'Guardar', onPressed: goToNextPage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
