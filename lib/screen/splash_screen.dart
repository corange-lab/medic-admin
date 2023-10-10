import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/splash_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: SvgPicture.asset(AppImages.medic_white_text, height: 60),
          ),
        );
      },
    );
  }
}
