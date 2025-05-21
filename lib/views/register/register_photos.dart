import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/theme/global_colors.dart';
import 'dart:io';
import 'package:timid/views/home.dart';
import 'package:timid/widgets/button_global.dart';

class RegisterPhotos extends StatefulWidget {
  @override
  _RegisterPhotosState createState() => _RegisterPhotosState();
}

class _RegisterPhotosState extends State<RegisterPhotos> {
  final ImagePicker picker = ImagePicker();
  RegisterProfile registerProfile = RegisterProfile();
  List<File?> images = List.filled(6, null);

  Future<void> pickImage(int index) async {
    print("pickImage() ha sido llamado para index: $index");

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);

      setState(() {
        images[index] = imageFile;
      });
    } else {
      print("No se seleccionó ninguna imagen.");
    }
  }

  void removeImage(int index) {
    setState(() {
      images[index] = null;
    });
  }

  Future<void> goToNextPage() async {
    int selectedImagesCount = images.where((image) => image != null).length;

    if (selectedImagesCount < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Has de pujar almenys 3 imatges')),
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
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
                    "Selecciona entre 3 i 6 fotos per al teu perfil:",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: images[index] != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        images[index]!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.cancel,
                                            color: AppColors.redHeart),
                                        onPressed: () => removeImage(index),
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Icon(Icons.add_a_photo,
                                      size: 40, color: Colors.white),
                                ),
                        ),
                      );
                    },
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
