import 'package:get/get.dart';
import 'package:medic_admin/model/user_model.dart';

class HomeController extends GetxController {
  Rx<UserModel?> loggedInUser = UserModel.newUser().obs;

  String getMobileNo() {
    if (loggedInUser.value?.mobileNo == null) {
      return '';
    }

    int? countryCode = loggedInUser.value?.countryCode;
    String? mobileNo = loggedInUser.value?.mobileNo ?? '';
    return '+${countryCode ?? ''} $mobileNo';
  }
}
