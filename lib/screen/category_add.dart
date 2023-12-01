// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class CategoryAdd extends StatelessWidget {
  PickImageController pickImageController = Get.put(PickImageController());
  MedicineController controller = Get.put(MedicineController());

  CategoryData? category;

  CategoryAdd({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      controller.categoryController.text = category?.name ?? "";
    }
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            category == null
                ? ConstString.addCategory
                : ConstString.updateCategory,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontFamily: AppFont.fontMedium),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    pickImageController.categoryImage =
                        await pickImageController.pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.tilePrimaryColor,
                        border: Border.all(color: AppColors.primaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ConstString.uploadCategoryImage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.categoryName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: AppFont.fontMedium),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: controller.categoryController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.newline,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      hintText: ConstString.enterGen,
                      hintStyle: TextStyle(
                          fontFamily: AppFont.fontMedium,
                          color: AppColors.phoneGrey,
                          fontSize: 14),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lineGrey)),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.validateCategoryData()) {
                        showProgressDialogue(context);
                        String id = controller.categoryRef.doc().id;

                        String? imageUrl =
                            await pickImageController.uploadImageToStorage(
                                pickImageController.categoryImage, id);

                        if (imageUrl == null) return;

                        if (category == null) {
                          CategoryData categoryData = CategoryData(
                              id: id,
                              name: controller.categoryController.text,
                              image: imageUrl);
                          await controller.storeCategoryData(categoryData);
                          pickImageController.categoryImage = null;
                        } else {
                          CategoryData categoryData = CategoryData(
                              id: category!.id,
                              name: controller.categoryController.text,
                              image: imageUrl);
                          await controller.updateCategory(categoryData);
                          pickImageController.categoryImage = null;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        fixedSize: const Size(200, 40),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      category == null
                          ? ConstString.addCategory
                          : ConstString.updateCategory,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.white,
                              ),
                    ))
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        controller.categoryController.clear();
        return true;
      },
    );
  }
}
