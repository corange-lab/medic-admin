import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImageController extends GetxController {
  final ImagePicker picker = ImagePicker();

  RxString imgPath = "".obs;

  pickMedicineImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    imgPath.value = pickedFile!.path;
  }
}
