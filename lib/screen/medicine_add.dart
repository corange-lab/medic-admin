// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class MedicineAdd extends StatelessWidget {
  PickImageController pickImageController = Get.put(PickImageController());
  MedicineController controller = Get.put(MedicineController());

  MedicineAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          ConstString.addMedicine,
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
                onTap: () {
                  pickImageController.pickMedicineImage();
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
              Obx(
                () => pickImageController.imgPath != ""
                    ? Text(
                        "Selected Image : ${pickImageController.imgPath}",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    : const SizedBox(),
              ),
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
              // Container(
              //   child: DropdownButton<String>(
              //     value: controller.preRequire.value,
              //     onChanged: (newValue) {
              //       controller.preRequire.value = newValue!;
              //     },
              //     items: const [
              //       DropdownMenuItem<String>(
              //         value: "Yes",
              //         child: Text("Yes"),
              //       ),
              //       DropdownMenuItem<String>(
              //         value: "No",
              //         child: Text("No"),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: const Size(200, 40),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    ConstString.addMedicine,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
