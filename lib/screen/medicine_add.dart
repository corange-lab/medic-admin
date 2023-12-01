// ignore_for_file: unrelated_type_equality_checks, must_be_immutable, unnecessary_null_comparison

import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class MedicineAdd extends StatelessWidget {
  PickImageController pickImageController = Get.put(PickImageController());
  MedicineController controller = Get.put(MedicineController());

  MedicineData? medicine;

  MedicineAdd({super.key, this.medicine});

  @override
  Widget build(BuildContext context) {
    if (medicine != null) {
      controller.medicineController.text = medicine?.genericName ?? "";
      controller.brandController.text = medicine?.brandName ?? "";
      controller.priceController.text =
          medicine!.medicinePrice.toString() ?? "";
      controller.descriptionController.text = medicine?.description ?? "";
      controller.categoryIdController.text = medicine?.categoryId ?? "";
      controller.ratinsController.text = medicine?.ratings ?? "";
      controller.usesController.text = medicine?.uses ?? "";
      controller.aboutController.text = medicine?.about ?? "";
      controller.directionUseController.text = medicine?.directionForUse ?? "";
      controller.benefitsController.text = medicine?.benefits ?? "";
      controller.drugInterController.text =
          medicine?.drugDrugInteractions ?? "";
      controller.safetyInfoController.text = medicine?.safetyInformation ?? "";
      controller.preRequire.value =
          medicine!.prescriptionRequire! ? "Yes" : "No";
    } else {
      controller.medicineController.clear();
      controller.brandController.clear();
      controller.priceController.clear();
      controller.descriptionController.clear();
      controller.categoryController.clear();
      controller.ratinsController.clear();
      controller.usesController.clear();
      controller.aboutController.clear();
      controller.directionUseController.clear();
      controller.benefitsController.clear();
      controller.drugInterController.clear();
      controller.safetyInfoController.clear();
      controller.categoryIdController.clear();
      controller.preRequire.value = "Yes";
    }
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            medicine == null
                ? ConstString.addMedicine
                : ConstString.updateMedicine,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontFamily: AppFont.fontMedium),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    pickImageController.image =
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
                            ConstString.uploadMedicineImage,
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
                // Obx(
                //   () => pickImageController.imgPath != ""
                //       ? Text(
                //           "Selected Image : ${pickImageController.imgPath}",
                //           style: Theme.of(context).textTheme.titleSmall,
                //         )
                //       : const SizedBox(),
                // ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.medicineName,
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
                    controller: controller.medicineController,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediBrand,
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
                    controller: controller.brandController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterBrand,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediDescription,
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
                    controller: controller.descriptionController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterDecsription,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediPrice,
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
                    controller: controller.priceController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterDecsription,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.medicineCategory,
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
                    controller: controller.categoryIdController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterCategory,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.medicineDiscount,
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
                    controller: controller.discountIdController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterDiscount,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediRate,
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
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: controller.ratinsController,
                    decoration: InputDecoration(
                      hintText: ConstString.enterRate,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.uses,
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
                    controller: controller.usesController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterUses,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediAbout,
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
                    controller: controller.aboutController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterAbout,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.direction,
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
                    controller: controller.directionUseController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterDirection,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.benefits,
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
                    controller: controller.benefitsController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterBeni,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.mediDrug,
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
                    controller: controller.drugInterController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterDrug,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.safety,
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
                    controller: controller.safetyInfoController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: ConstString.enterSafety,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.prescription,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: AppFont.fontMedium),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Obx(() => Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.lineGrey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButton<String?>(
                            underline: const SizedBox(),
                            value: controller.preRequire.value,
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: AppColors.white,
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppIcons.arrowDown,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            onChanged: (newValue) {
                              controller.preRequire.value = newValue!;
                            },
                            items: const [
                              DropdownMenuItem<String?>(
                                value: "Yes",
                                child: Text("Yes"),
                              ),
                              DropdownMenuItem<String?>(
                                value: "No",
                                child: Text("No"),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstString.type,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: AppFont.fontMedium),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(() => Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.lineGrey),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 15),
                          hint: Text(
                            "Select Discount Type",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 15, color: AppColors.txtGrey),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AppIcons.arrowDown,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          dropdownColor: AppColors.white,
                          onChanged: (value) {
                            controller.type.value = value!;
                          },
                          items: controller.typeList.isNotEmpty
                              ? controller.typeList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15),
                                    ),
                                  );
                                }).toList()
                              : null,
                          value: controller.typeList
                                  .contains(controller.type.value)
                              ? controller.type.value
                              : null,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.validateData()) {
                        showProgressDialogue(context);
                        String id = controller.medicineRef.doc().id;

                        String? imageUrl =
                            await pickImageController.uploadImageToStorage(
                                pickImageController.image, id);

                        // if (imageUrl == null) return;

                        if (medicine == null) {
                          MedicineData medicineData = MedicineData(
                              id: id,
                              genericName: controller.medicineController.text,
                              brandName: controller.brandController.text,
                              description:
                                  controller.descriptionController.text,
                              medicinePrice:
                                  int.parse(controller.priceController.text),
                              categoryId: controller.categoryIdController.text,
                              discountId: controller.discountIdController.text,
                              ratings: controller.ratinsController.text,
                              image: imageUrl,
                              uses: controller.usesController.text,
                              about: controller.aboutController.text,
                              directionForUse:
                                  controller.directionUseController.text,
                              benefits: controller.benefitsController.text,
                              drugDrugInteractions:
                                  controller.drugInterController.text,
                              safetyInformation:
                                  controller.safetyInfoController.text,
                              prescriptionRequire:
                                  controller.preRequire.value == "Yes"
                                      ? true
                                      : false,
                              type: controller.type.value);
                          await controller.storeMedicineData(medicineData);
                          pickImageController.image = null;
                        } else {
                          MedicineData medicineData = MedicineData(
                              id: medicine!.id,
                              genericName: controller.medicineController.text,
                              brandName: controller.brandController.text,
                              description:
                                  controller.descriptionController.text,
                              medicinePrice:
                                  int.parse(controller.priceController.text),
                              categoryId: controller.categoryIdController.text,
                              discountId: controller.discountIdController.text,
                              ratings: controller.ratinsController.text,
                              image: imageUrl,
                              uses: controller.usesController.text,
                              about: controller.aboutController.text,
                              directionForUse:
                                  controller.directionUseController.text,
                              benefits: controller.benefitsController.text,
                              drugDrugInteractions:
                                  controller.drugInterController.text,
                              safetyInformation:
                                  controller.safetyInfoController.text,
                              prescriptionRequire:
                                  controller.preRequire.value == "Yes"
                                      ? true
                                      : false,
                              type: controller.type.value);
                          await controller.updateMedicine(medicineData);
                          pickImageController.image = null;
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
                      medicine == null
                          ? ConstString.addMedicine
                          : ConstString.updateMedicine,
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
        controller.clearController();
        return true;
      },
    );
  }
}
