import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/user_controller.dart';
import 'package:medic_admin/model/user_model.dart';
import 'package:medic_admin/screen/add_discount_screen.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';

class UserList extends StatelessWidget {
  Function()? onPressedMenu;

  UserList({super.key, this.onPressedMenu});

  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchUserList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error :${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<UserModel> userList = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  if (onPressedMenu != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 00),
                        child: IconButton(
                          onPressed: onPressedMenu,
                          icon: Icon(
                            Icons.menu,
                            color: AppColors.txtGrey,
                          ),
                        ),
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lineGrey),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                userList[index].profilePicture != null &&
                                        userList[index].profilePicture != ""
                                    ? ClipOval(
                                        child: CachedNetworkImage(
                                          // fit: BoxFit.cover,
                                          height: 60,
                                          width: 60,
                                          imageUrl:
                                              "https://firebasestorage.googleapis.com/v0/b/medic-87909.appspot.com/o/profiles%2F1jVqrSl8gMMKuJU3jzkfpSfDGEt2?alt=media&token=8fb91338-8da5-4899-9609-2c75cedad865",
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    AppColors.tilePrimaryColor),
                                            child: Icon(
                                              Icons.error_outline,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              SizedBox(
                                            width: 60,
                                            child: Center(
                                              child: CupertinoActivityIndicator(
                                                color: AppColors.primaryColor,
                                                animating: true,
                                                radius: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: Container(
                                            height: 60,
                                            width: 60,
                                            color: AppColors.primaryColor,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    AppImages
                                                        .medic_white_text)))),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        userList[index].name != "" &&
                                                userList[index].name != null
                                            ? userList[index].name!
                                            : "Medic User",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontSize: 16,
                                                color: AppColors.primaryColor,
                                                fontFamily:
                                                    AppFont.fontSemiBold)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile No.: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  color: AppColors.txtGrey),
                                        ),
                                        Text(
                                          "+${userList[index].countryCode} ${userList[index].mobileNo}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontSemiBold,
                                                  color: AppColors
                                                      .darkPrimaryColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "E-mail : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  color: AppColors.txtGrey),
                                        ),
                                        Text(
                                          userList[index].email != "" &&
                                                  userList[index].email != null
                                              ? userList[index].email!
                                              : "No Email Found!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontSemiBold,
                                                  color: AppColors
                                                      .darkPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text("No Data Found");
        }
      },
    );
  }
}
