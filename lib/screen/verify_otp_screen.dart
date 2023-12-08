import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/controller/simple_ui_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends GetWidget<AuthController> {
  VerifyOtpScreen({super.key, required String phoneNumber});

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
                    child: Text(ConstString.enterOTP,
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: size.width > 600
                          ? size.width * 0.4
                          : size.width * 0.5,
                      child: PinCodeTextField(
                        controller: controller.otpController,
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.none,
                        blinkWhenObscuring: true,
                        hintCharacter: "-",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontFamily: AppFont.fontRegular,
                                color: AppColors.darkPrimaryColor
                                    .withOpacity(0.3)),
                        cursorColor: AppColors.txtGrey,
                        keyboardType: TextInputType.number,
                        textStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontFamily: AppFont.fontRegular,
                                color: AppColors.darkPrimaryColor),
                        pastedTextStyle: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontFamily: AppFont.fontRegular,
                                color: AppColors.darkPrimaryColor),
                        pinTheme: PinTheme(
                          fieldWidth: 35,
                          selectedColor: AppColors.dark,
                          activeColor: AppColors.primaryColor,
                          inactiveColor: AppColors.txtGrey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (controller.otpController.text.isEmpty) {
                                  showInSnackBar(
                                    ConstString.enterOtp,
                                    title: ConstString.enterOtpMessage,
                                  );
                                  return;
                                }
                                AuthController auth =
                                    Get.find<AuthController>();
                                FocusManager.instance.primaryFocus?.unfocus();
                                await controller.verifyOtp(context, auth.user);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  fixedSize: const Size(200, 50),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                ConstString.verify,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () async {
                        await controller.verifyPhoneNumber();
                      },
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: ConstString.dontgetOTP,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 16,
                                    color: AppColors.txtGrey,
                                    fontFamily: AppFont.fontMedium)),
                        TextSpan(
                            text: ConstString.resendOTP,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                    fontFamily: AppFont.fontMedium))
                      ])),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<AuthController>(
                      id: 'timer',
                      builder: (ctrl) {
                        return Visibility(
                          visible: ctrl.start.value != 0,
                          child: Center(
                            child: Obx(
                              () => Text(
                                  "00 : ${ctrl.start.value}${ctrl.start.value == 1 ? '' : ' Sec'}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontFamily: AppFont.fontSemiBold)),
                            ),
                          ),
                        );
                      }),
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
}
