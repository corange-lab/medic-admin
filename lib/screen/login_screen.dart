import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:medic_admin/widgets/custom_loading_widget.dart';

class LoginScreen extends GetWidget<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Login User"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 30),
              Text(ConstString.welcome,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 20)),
              const SizedBox(height: 8),
              Text(ConstString.enterPhone,
                  style: Theme.of(context).textTheme.displaySmall!),
              const SizedBox(height: 30),
              Text(ConstString.userName,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColors.txtGrey2, fontSize: 14)),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: controller.firstNameController,
                          decoration: InputDecoration(
                              hintText: ConstString.enterFirstName,
                              hintStyle: TextStyle(
                                  fontFamily: AppFont.fontMedium,
                                  color: AppColors.phoneGrey,
                                  fontSize: 14),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey))))),
                  SizedBox(width: 15),
                  Expanded(
                      child: TextField(
                          controller: controller.lastNameController,
                          decoration: InputDecoration(
                              hintText: ConstString.enterLastName,
                              hintStyle: TextStyle(
                                  fontFamily: AppFont.fontMedium,
                                  color: AppColors.phoneGrey,
                                  fontSize: 14),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.lineGrey)))))
                ],
              ),
              const SizedBox(height: 15),
              Text(ConstString.gender,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColors.txtGrey2, fontSize: 14)),
              const SizedBox(height: 8),
              Obx(() => CupertinoSlidingSegmentedControl<UserGender>(
                    backgroundColor: AppColors.decsGrey,
                    thumbColor: AppColors.primaryColor,
                    groupValue: controller.selectedGender.value,
                    onValueChanged: (UserGender? value) {
                      if (value != null) {
                        controller.selectedGender.value = value;
                      }
                    },
                    children: <UserGender, Widget>{
                      UserGender.male: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          UserGender.male.name.capitalizeFirst.toString(),
                          style: TextStyle(
                            color: UserGender.male !=
                                    controller.selectedGender.value
                                ? AppColors.primaryColor
                                : CupertinoColors.white,
                            fontFamily: AppFont.fontRegular,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      UserGender.female: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          UserGender.female.name.capitalizeFirst.toString(),
                          style: TextStyle(
                            color: UserGender.female !=
                                    controller.selectedGender.value
                                ? AppColors.primaryColor
                                : CupertinoColors.white,
                            fontFamily: AppFont.fontRegular,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      UserGender.other: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Text(
                          UserGender.other.name.capitalizeFirst.toString(),
                          style: TextStyle(
                            color: UserGender.other !=
                                    controller.selectedGender.value
                                ? AppColors.primaryColor
                                : CupertinoColors.white,
                            fontFamily: AppFont.fontRegular,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    },
                  )),
              const SizedBox(height: 30),
              Text(ConstString.mobileNumber,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColors.txtGrey2, fontSize: 14)),
              Row(
                children: [
                  Expanded(
                      child: CountryCodePicker(showCountryOnly: true,showFlagMain: true,
                    onChanged: (CountryCode? countryData) {
                      controller.countryData = countryData;
                    },
                    initialSelection: 'SL',
                    showFlag: true,
                    showFlagDialog: true,
                    dialogTextStyle: TextStyle(fontFamily: AppFont.fontRegular),
                    searchStyle: TextStyle(fontFamily: AppFont.fontRegular),
                    // showDropDownButton: true,
                    textStyle: TextStyle(fontFamily: AppFont.fontMedium),
                    alignLeft: true,
                    enabled: true,
                  )),
                  Expanded(
                      flex: 3,
                      child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneNumberController,
                          decoration: InputDecoration(
                              hintText: ConstString.enterMobile,
                              hintStyle: TextStyle(
                                  fontFamily: AppFont.fontMedium,
                                  color: AppColors.phoneGrey,
                                  fontSize: 14),
                              border:OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),
                              focusedErrorBorder:
                              OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppColors.lineGrey)),)))
                ],
              ),
              const SizedBox(height: 100),
              continueButton(context),
            ]),
          ),
        )));
  }

  GetBuilder<AuthController> continueButton(BuildContext context) {
    return GetBuilder<AuthController>(
      id: AuthController.continueButtonId,
      builder: (ctrl) {
        if (controller.isOtpSent.value) {
          return Center(
            child: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const CustomLoadingWidget()),
          );
        }
        return Align(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () async {
                      if (controller.validateData()) {
                        await controller.actionVerifyPhone();
                      }
                    },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: const Size(200, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                ConstString.sendOTP,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                    ),
              )),
        );
      },
    );
  }
}
