// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class PickImageController extends GetxController {
//   final ImagePicker picker = ImagePicker();
//
//   RxString imgPath = "".obs;
//
//   Future<XFile?> pickMedicineImage() async {
//     return await picker.pickImage(source: ImageSource.gallery);
//     // imgPath.value = pickedFile!.path;
//   }
// }

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

final ImagePicker _picker = ImagePicker();

class PickImageController extends GetxController {
  Rx<XFile?> image = Rx<XFile?>(null);
  Rx<XFile?> categoryImage = Rx<XFile?>(null);

  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String?> uploadImageToStorage(XFile? image, String id) async {
    if (image == null) return null;

    // Get the file extension
    String fileExtension = path.extension(image.name);

    // Ensure the file is an image
    if (!['.png', '.jpg', '.jpeg', '.gif', '.avif', '.svg']
        .contains(fileExtension.toLowerCase())) {
      print('The selected file is not an image.');
      return null;
    }

    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('categories/${id}');

      Uint8List? imageData = await image.readAsBytes();

      firebase_storage.TaskSnapshot snapshot = await ref.putData(
          imageData,
          firebase_storage.SettableMetadata(
              contentType:
                  'image/$fileExtension') // Setting the content type for image
          );

      // When complete, this will return the URL for the uploaded image
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e); // Handle any errors
      return null;
    }
  }
}
