import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/screen/category_add.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class ViewCategory extends StatelessWidget {
  const ViewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MedicineController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: Text(
              ConstString.viewCategory,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppFont.fontMedium),
            ),
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
          ),
          body: categoryWidget(controller),
        );
      },
    );
  }

  Widget categoryWidget(MedicineController controller) {
    return StreamBuilder(
      stream: controller.fetchCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<CategoryData> categoryList = snapshot.data!;
          return ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.decsGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: AppColors.lineGrey)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl: categoryList[index].image ?? '',
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                              width: 120,
                              child: Center(
                                  child: SizedBox(
                                height: 35,
                                width: 35,
                                child: LoadingIndicator(
                                  colors: [AppColors.primaryColor],
                                  indicatorType: Indicator.ballScale,
                                  strokeWidth: 1,
                                ),
                              )),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${categoryList[index].name}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFont.fontMedium),
                        ),
                        Spacer(),
                        PopupMenuButton(
                          elevation: 3,
                          shadowColor: AppColors.txtGrey.withOpacity(0.1),
                          icon: SvgPicture.asset(
                            AppIcons.more,
                            color: Colors.black,
                          ),
                          onSelected: (value) async {},
                          padding: EdgeInsets.zero,
                          itemBuilder: (context) => <PopupMenuEntry>[
                            PopupMenuItem(
                              onTap: () {
                                Get.to(() => CategoryAdd(
                                  category: categoryList[index],
                                ));
                              },
                              height: 35,
                              value: "Edit",
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppIcons.edit),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Edit",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                        fontFamily:
                                        AppFont.fontMedium,
                                        fontSize: 14,
                                        color: AppColors.txtGrey),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () async {
                                showProgressDialogue(context);
                                await controller
                                    .deleteCategory(categoryList[index].id!);
                              },
                              height: 35,
                              value: "Delete",
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.delete,
                                    height: 14,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Delete",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                        fontFamily:
                                        AppFont.fontMedium,
                                        fontSize: 14,
                                        color: AppColors.txtGrey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("No Category Found!"));
        }
      },
    );
  }
}
