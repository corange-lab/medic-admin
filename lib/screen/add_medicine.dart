import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class AddMedicine extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());
  PickImageController pickController = Get.put(PickImageController());

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await pickController.pickMedicineImage();
              print("Image Path : ${pickController.imgPath}");
            },
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.tilePrimaryColor,
                  border: Border.all(color: AppColors.primaryColor, width: 1)),
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
                  hintText: ConstString.medicineName,
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
              ConstString.mediPrice,
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
              controller: controller.priceController,
              decoration: InputDecoration(
                  hintText: ConstString.price,
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
          ElevatedButton(
              onPressed: () {
                showProgressDialogue(context);
                String id = controller.medicineRef.doc().id;
                Medicine medicine = Medicine(
                    id: id,
                    medicineName: controller.medicineController.text.trim(),
                    price: controller.priceController.text.trim(),
                    description: controller.descriptionController.text.trim());

                if (controller.validateData()) {
                  controller.medicineRef
                      .doc(id)
                      .set(medicine.toMap())
                      .then((value) {
                    Get.back();
                    showInSnackBar("Medicine Data Added Successfully",
                        title: 'Medicine Added', isSuccess: true);
                  });
                }
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
    );
  }
}
