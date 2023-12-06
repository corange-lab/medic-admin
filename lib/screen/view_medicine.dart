// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/screen/medicine_add.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class ViewMedicine extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());
  Function()? onPressedMenu;

  ViewMedicine({super.key, this.onPressedMenu});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.fetchMedicine(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error : ${snapshot.error}"));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<MedicineData> medicine = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                if (onPressedMenu != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: medicine.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.decsGrey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: AppColors.lineGrey)),
                        child: ExpansionTile(
                          backgroundColor: AppColors.decsGrey,
                          iconColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                medicine[index].genericName ??
                                    "Unknown Medicine",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontFamily: AppFont.fontBold,
                                        fontSize: 17,
                                        color: AppColors.primaryColor),
                              ),
                              Text(
                                "Price : LE ${medicine[index].medicinePrice.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontFamily: AppFont.fontMedium),
                              )
                            ],
                          ),
                          children: [
                            // Place your details here inside the children of ExpansionTile
                            medicineDetailTile(
                                context, "Brand:", medicine[index].brandName),
                            medicineDetailTile(
                                context, "About:", medicine[index].about),
                            medicineDetailTile(
                                context, "Benefits:", medicine[index].benefits),
                            medicineDetailTile(context, "Directions:",
                                medicine[index].directionForUse),
                            medicineDetailTile(context, "Interactions:",
                                medicine[index].drugDrugInteractions),
                            medicineDetailTile(
                                context, "Uses:", medicine[index].uses),
                            medicineDetailTile(context, "Safety Information:",
                                medicine[index].safetyInformation),
                            medicineDetailTile(context, "Reviews:",
                                medicine[index].ratings.toString()),
                            medicineDetailTile(context, "Description:",
                                medicine[index].description),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        showProgressDialogue(context);
                                        await controller.deleteMedicine(
                                            medicine[index].id!);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.red,
                                          fixedSize: const Size(150, 40),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      child: Text(
                                        "Delete",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      )),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => MedicineAdd(
                                              medicine: medicine[index],
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          fixedSize: const Size(150, 40),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      child: Text(
                                        "Edit",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
              child: Text(
            "No Data Found!!!",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontFamily: AppFont.fontSemiBold),
          ));
        }
      },
    );
  }

  Widget medicineDetailTile(BuildContext context, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Text(
            "$label ",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: AppFont.fontMedium),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
