// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class AddMedicine extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());
  PickImageController pickController = Get.put(PickImageController());

  AddMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          ConstString.addMedicine,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: medicineWidget(context, controller, pickController),
    );
  }

  Widget medicineWidget(BuildContext context, MedicineController controller,
      PickImageController pickController) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await pickController.pickMedicineImage();
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.tilePrimaryColor,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1)),
                alignment: Alignment.center,
                child: Text(
                  "Upload Medicine Image",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.primaryColor),
                ),
              ),
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Selected Image : ${pickController.imgPath.value}")),
                )),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstString.disMedicineName,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.medicineController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
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
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.brandController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
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
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.descriptionController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
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
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.aboutController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstString.mediSafety,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.safetyInfoController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstString.mediDirection,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.directionUseController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstString.mediBeni,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.benefitsController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
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
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.drugInterController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstString.mediUses,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.usesController,
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
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
                    .copyWith(color: AppColors.darkPrimaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
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
                        borderSide: BorderSide(color: AppColors.lineGrey)))),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  addMedicine(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: const Size(200, 45),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  ConstString.add,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: AppColors.white,
                      ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> addMedicine(BuildContext context) async {
    if (!controller.validateData()) {
      // Handle validation failure
      return;
    }
    showProgressDialogue(context);
    String id = controller.medicineRef.doc().id;
    File pickFile = File(pickController.imgPath.value);

    // if (await pickFile.exists()) {
    try {
      String imageUrl = await uploadImage(pickFile, 'medicine_img/$id');

      MedicineData medicine = MedicineData(
          image: imageUrl,
          genericName: controller.medicineController.text.trim(),
          benefits: controller.benefitsController.text,
          brandName: controller.brandController.text,
          directionForUse: controller.directionUseController.text,
          drugDrugInteractions: controller.drugInterController.text,
          safetyInformation: controller.safetyInfoController.text,
          uses: controller.usesController.text,
          description: controller.descriptionController.text.trim(),
          about: controller.aboutController.text);
      await saveMedicineData(id, medicine.toMap());

      Get.back();
      showInSnackBar("Medicine Data Added Successfully",
          title: 'Medicine Added', isSuccess: true);
    } catch (e) {
      print("Exception Thrown : $e");
      showInSnackBar("Error adding medicine: $e",
          title: 'Error', isSuccess: false);
    }
    // }
  }

  Future<String> uploadImage(File file, String path) async {
    Reference ref = FirebaseStorage.instance.ref(path);
    UploadTask uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() => null); // Wait for upload completion
    return await ref.getDownloadURL(); // Get and return URL
  }

  Future<void> saveMedicineData(String id, Map<String, dynamic> data) async {
    await controller.medicineRef.doc(id).set(data);
  }
}
