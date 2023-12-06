import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/auth_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class LogoutDialog extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: AppColors.white,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12)),
      alignment: Alignment.center,
      title: Column(
        children: [
          Text(
            ConstString.logoutDialogue,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.darkPrimaryColor,
              fontFamily: AppFont.fontBold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 14,
                  color: AppColors.txtGrey,
                  letterSpacing: 0),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.decsGrey,
                        fixedSize: const Size(200, 45),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      ConstString.cancle,
                      style:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: AppColors.txtGrey,
                      ),
                    )),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      showProgressDialogue(context);
                      await authController.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        fixedSize: const Size(200, 50),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      ConstString.logoutDialogue,
                      style:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
