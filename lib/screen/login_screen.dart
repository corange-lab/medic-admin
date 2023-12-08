import 'package:country_calling_code_picker/picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/simple_ui_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/custom_loading_widget.dart';

class LoginScreen extends GetWidget<AuthController> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.put(SimpleUIController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size, simpleUIController, context);
            } else {
              return _buildSmallScreen(size, simpleUIController, context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'asset/coin.json',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, simpleUIController, context),
        ),
      ],
    );
  }

  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, BuildContext context) {
    return Center(
      child: _buildMainBody(size, simpleUIController, context),
    );
  }

  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
              ? Container()
              : Lottie.asset(
                  'asset/wave.json',
                  height: size.height * 0.2,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SvgPicture.asset(
              AppImages.medic_teal_text,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Welcome To The Medic',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.darkPrimaryColor.withOpacity(0.8),
                  fontFamily: AppFont.fontSemiBold,
                  fontSize: 23),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(ConstString.mobileNumber,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.txtGrey2,
                                fontSize: 16,
                                fontFamily: AppFont.fontMedium)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: AppColors.lineGrey, width: 1)),
                        child: Obx(
                          () => TextButton(
                              onPressed: () {
                                _showCountryPicker(context);
                              },
                              child: Text(
                                controller.countryCode.value,
                                style: TextStyle(
                                    fontFamily: AppFont.fontMedium,
                                    fontSize: 15,
                                    color: AppColors.darkPrimaryColor),
                              )),
                        ),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: controller.phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: ConstString.enterMobile,
                                  hintStyle: TextStyle(
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.phoneGrey,
                                      fontSize: 14),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColors.lineGrey)),
                                )),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  continueButton(context),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker(BuildContext context) async {
    final country = await showCountryPickerDialog(context,
        cornerRadius: 10,
        focusSearchBox: false,
        title: Text(
          "Select Country",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: AppColors.primaryColor,
              fontFamily: AppFont.fontBold,
              fontSize: 20),
        ));
    controller.countryCode.value = country!.callingCode;
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
          child: Row(
            children: [
              Expanded(
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
                        fixedSize: const Size(double.infinity, 50),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(
                      ConstString.sendOTP,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: Colors.white,
                              fontFamily: AppFont.fontMedium,
                              fontSize: 16),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
