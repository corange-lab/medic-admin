import 'dart:async';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/user_repository.dart';
import 'package:medic_admin/model/user_model.dart';
import 'package:medic_admin/screen/home_screen.dart';
import 'package:medic_admin/screen/login_screen.dart';
import 'package:medic_admin/screen/verify_otp_screen.dart';
import 'package:medic_admin/utils/app_storage.dart';
import 'package:medic_admin/utils/controller_ids.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class AuthController extends GetxController {
  RxString verificationId = "".obs;
  RxString otp = ''.obs;

  RxString verificationid = "".obs;
  bool isLoading = false;

  RxBool isNewUser = false.obs;
  RxBool isOtpSent = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String countryName = '';
  UserModel? userModel;
  User? user;
  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;

  TextEditingController phoneNumberController = TextEditingController();

  FocusNode phoneNumberTextField = FocusNode();

  AppStorage appStorage = AppStorage();

  static const continueButtonId = 'continueButtonId';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  CountryCode? countryData;

  @override
  void onInit() {
    super.onInit();
    countryData = CountryCode.fromCountryCode('SL');
  }

  bool validateData() {
    if (phoneNumberController.text.trim().isEmpty) {
      showInSnackBar("Please enter phone number.",
          title: 'Required!', isSuccess: false);
      return false;
    }
    return true;
  }

  Future<void> actionVerifyPhone() async {
    update([AuthController.continueButtonId]);
    FocusManager.instance.primaryFocus?.unfocus();

    await verifyPhoneNumber();

    update([AuthController.continueButtonId]);
  }

  String getPhoneNumber() {
    if (countryData?.dialCode == null) {
      return '';
    }
    String mPhoneNumber = phoneNumberController.text.trim();
    String phone = (countryData!.dialCode! + mPhoneNumber).replaceAll('+', '');
    print('phone $phone');
    return phone;
  }

  Future<void> verifyPhoneNumber({bool second = false}) async {
    bool isValid = validateData();
    if (isValid) {
      isOtpSent = true.obs;
      update([continueButtonId]);
      try {
        print('getPhoneNumber() ${getPhoneNumber()}');
        await _auth.verifyPhoneNumber(
          phoneNumber: '+${getPhoneNumber()}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            isOtpSent = false.obs;
            update([continueButtonId]);
            UserCredential userCredential =
                await _auth.signInWithCredential(credential);
            if (userCredential.user?.uid != null) {
              var gotUser = await _createUserInUserCollection(userCredential);
              await loginToPortal(gotUser);
            }
            showInSnackBar(ConstString.successLogin, isSuccess: true);
          },
          verificationFailed: (FirebaseAuthException exception) {
            isOtpSent = false.obs;
            update([continueButtonId]);

            log("Verification error ${exception.message}");
            isLoading = false;
            update([ControllerIds.verifyButtonKey]);
            authException(exception);
          },
          codeSent:
              (String currentVerificationId, int? forceResendingToken) async {
            verificationId.value = currentVerificationId;
            isOtpSent = false.obs;
            update([continueButtonId]);
            log("$verificationId otp is sent ");
            showInSnackBar(ConstString.otpSent, isSuccess: true);

            start.value = 30;
            if (timer?.isActive != true) {
              startTimer();
            }

            if (!second) {
              Get.off(() => VerifyOtpScreen(phoneNumber: getPhoneNumber()));
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            isOtpSent = false.obs;
            update([continueButtonId]);

            verificationid = verificationId.obs;
          },
        );
      } catch (e) {
        log("------verify number with otp sent-----$e");
      }
    }
  }

  RxInt startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          resendButton = false.obs;
        } else {
          start.value != 0 ? start-- : null;
          update(['timer']);
        }
      },
    );
    return start;
  }

  void authException(FirebaseAuthException e) {
    switch (e.code) {
      case ConstString.invalidVerificationCode:
        return showInSnackBar(ConstString.invalidVerificationMessage);
      case ConstString.invalidPhoneNumber:
        return showInSnackBar(
          ConstString.invalidPhoneFormat,
          title: ConstString.invalidPhoneMessage,
        );
      case ConstString.networkRequestFailed:
        return showInSnackBar(ConstString.checkNetworkConnection);
      case ConstString.userDisabled:
        return showInSnackBar(ConstString.accountDisabled);
      case ConstString.sessionExpired:
        return showInSnackBar(ConstString.sessionExpiredMessage);
      case ConstString.quotaExceed:
        return showInSnackBar(ConstString.quotaExceedMessage);
      case ConstString.tooManyRequest:
        return showInSnackBar(ConstString.tooManyRequestMessage);
      case ConstString.captchaCheckFailed:
        return showInSnackBar(ConstString.captchaFailedMessage);
      case ConstString.missingPhoneNumber:
        return showInSnackBar(ConstString.missingPhoneNumberMessage);
      default:
        return showInSnackBar(e.message);
    }
  }

  Future<void> signOut() async {
    // await NotificationService.instance.reGenerateFCMToken();
    phoneNumberController.clear();
    AppStorage appStorage = AppStorage();
    appStorage.appLogout();
    isLoading = false;
    Get.delete<AuthController>();
    Get.put(AuthController(), permanent: true);
    Get.back();
    await Get.offAll(() => LoginScreen());
    await FirebaseAuth.instance.signOut();
  }

  Future<void> verifyOtp(BuildContext context, User? user) async {
    if (otp.value.isEmpty) {
      showInSnackBar(
        ConstString.enterOtp,
        title: ConstString.enterOtpMessage,
      );
      return;
    }
    isLoading = true;
    update([ControllerIds.verifyButtonKey]);
    try {
      showProgressDialogue(context);
      final UserCredential result;
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp.value);

      if (user != null) {
        if (user.phoneNumber == null) {
          result = await user.linkWithCredential(phoneAuthCredential);
          log('data to check 1 ${getPhoneNumber()}');
          var gotUser = await _createUserInUserCollection(result);
          await loginToPortal(gotUser);
          isLoading = false;
          update([ControllerIds.verifyButtonKey]);
          return;
        } else {
          result = await _auth.signInWithCredential(phoneAuthCredential);
          log(ConstString.successLogin);
        }
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      } else {
        result = await _auth.signInWithCredential(phoneAuthCredential);
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      }
      isLoading = true;
      update([ControllerIds.verifyButtonKey]);
      if (result.additionalUserInfo?.isNewUser ?? false) {
        log('data to check 2 ${getPhoneNumber()}');
        var gotUser = await _createUserInUserCollection(result);
        await loginToPortal(gotUser);
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      } else {
        var gotUser = await _createUserInUserCollection(result);
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);

        await loginToPortal(gotUser);
      }
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    } on FirebaseAuthException catch (e) {
      Get.back();
      authException(e);
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    } catch (e) {
      Get.back();
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    }
  }

  Future<void> loginToPortal(UserModel? gotUser) async {
    if (gotUser != null &&
        gotUser.role != null &&
        (gotUser.role ?? []).contains('admin')) {
      await appStorage.setUserData(gotUser);
      // await NotificationService.instance.getTokenAndUpdateCurrentUser();
      await Get.offAll(() => HomeScreen());
    } else {
      showInSnackBar('Only admin can login.', isSuccess: false);
      return;
    }
  }

  Future<UserModel?> _createUserInUserCollection(
      UserCredential credentials) async {
    bool isUserExist =
        await UserRepository.instance.isUserExist(credentials.user!.uid);
    if (!isUserExist) {
      return null;
    } else {
      return await UserRepository.instance.fetchUser(credentials.user!.uid);
    }
  }
}
