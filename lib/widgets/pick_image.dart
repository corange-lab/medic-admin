import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_for_web/image_cropper_for_web.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController extends GetxController {
  final ImagePicker picker = ImagePicker();
  CroppedFile? croppedPostFile;

  RxString imgPath = "".obs;

  pickMedicineImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    imgPath.value = pickedFile!.path;
  }
}
