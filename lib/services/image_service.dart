import 'package:flutter/material.dart';

class ImageService {
  static ImageProvider getUserAvatar(dynamic images,
      {String fallbackAsset = 'assets/images/default_avatar.png'}) {
    if (images != null && images is List && images.isNotEmpty) {
      return NetworkImage(images[0]);
    } else {
      return AssetImage(fallbackAsset);
    }
  }
}
