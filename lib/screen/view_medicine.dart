// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/screen/medicine_add.dart';
import 'package:medic_admin/screen/medicine_details.dart';
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: medicine.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MedicineDetails(
                                medicine: medicine[index],
                              ));
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: controller.popularColorList[
                                index % (controller.popularColorList.length)],
                          ),
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                AppImages.designVector,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                  top: 20,
                                  left: 15,
                                  child: Text(
                                    medicine[index].genericName ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.white,
                                            fontFamily: AppFont.fontMedium,
                                            fontSize: 20),
                                  )),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Image.asset(
                                    controller.medicineImageList[index %
                                        (controller.medicineImageList.length)],
                                    height: 120,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: medicine.length,
                //   itemBuilder: (context, index) {
                //     return Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 20, vertical: 10),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: AppColors.decsGrey,
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(
                //                 width: 1, color: AppColors.lineGrey)),
                //         child: ExpansionTile(
                //           backgroundColor: AppColors.decsGrey,
                //           iconColor: AppColors.primaryColor,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10)),
                //           title: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 medicine[index].genericName ??
                //                     "Unknown Medicine",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .titleMedium!
                //                     .copyWith(
                //                         fontFamily: AppFont.fontBold,
                //                         fontSize: 17,
                //                         color: AppColors.primaryColor),
                //               ),
                //               Text(
                //                 "Price : LE ${medicine[index].medicinePrice.toString()}",
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .titleMedium!
                //                     .copyWith(fontFamily: AppFont.fontMedium),
                //               )
                //             ],
                //           ),
                //           children: [
                //             // Place your details here inside the children of ExpansionTile
                //             medicineDetailTile(
                //                 context, "Brand:", medicine[index].brandName),
                //             medicineDetailTile(
                //                 context, "About:", medicine[index].about),
                //             medicineDetailTile(
                //                 context, "Benefits:", medicine[index].benefits),
                //             medicineDetailTile(context, "Directions:",
                //                 medicine[index].directionForUse),
                //             medicineDetailTile(context, "Interactions:",
                //                 medicine[index].drugDrugInteractions),
                //             medicineDetailTile(
                //                 context, "Uses:", medicine[index].uses),
                //             medicineDetailTile(context, "Safety Information:",
                //                 medicine[index].safetyInformation),
                //             medicineDetailTile(context, "Reviews:",
                //                 medicine[index].ratings.toString()),
                //             medicineDetailTile(context, "Description:",
                //                 medicine[index].description),
                //             Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 20, vertical: 10),
                //               child: ,
                //             ),
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
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
