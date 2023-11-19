import 'package:firebase_storage/firebase_storage.dart';

class ProductStorage {
  // Reference to the root storage
  static final Reference _storageRef = FirebaseStorage.instance.ref();

  // Reference to the "images" folder
  static final Reference _imagesRef = _storageRef.child("assets");

  // Create a product storage reference under "images"
  static Future<String> getProductImageUrl(String imageName) async {
    try {
      Reference imageRef = _imagesRef.child(imageName);
      String downloadUrl = await imageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error getting product image URL: $e");
      throw e;
    }
  }
}
