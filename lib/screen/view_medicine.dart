// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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

  ViewMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          ConstString.viewMedicine,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: medicineWidget(context, controller),
    );
  }

  Widget medicineWidget(BuildContext context, MedicineController controller) {
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
          // return ListView.builder(
          //   itemCount: medicine.length,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             color: AppColors.decsGrey,
          //             borderRadius: BorderRadius.circular(10),
          //             border: Border.all(width: 1, color: AppColors.lineGrey)),
          //         child: Padding(
          //           padding: const EdgeInsets.all(10.0),
          //           child: Column(
          //             children: [
          //               const SizedBox(
          //                 height: 5,
          //               ),
          //               Align(
          //                 alignment: Alignment.centerLeft,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       medicine[index].genericName!,
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .titleMedium!
          //                           .copyWith(
          //                               fontFamily: AppFont.fontBold,
          //                               fontSize: 17,
          //                               color: AppColors.primaryColor),
          //                     ),
          //                     PopupMenuButton(
          //                       elevation: 3,
          //                       shadowColor: AppColors.txtGrey.withOpacity(0.1),
          //                       icon: SvgPicture.asset(
          //                         AppIcons.more,
          //                         color: Colors.black,
          //                       ),
          //                       onSelected: (value) async {},
          //                       padding: EdgeInsets.zero,
          //                       itemBuilder: (context) => <PopupMenuEntry>[
          //                         PopupMenuItem(
          //                           onTap: () {

          //                           },
          //                           height: 35,
          //                           value: "Edit",
          //                           child: Row(
          //                             children: [
          //                               SvgPicture.asset(AppIcons.edit),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Edit",
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .titleSmall!
          //                                     .copyWith(
          //                                         fontFamily:
          //                                             AppFont.fontMedium,
          //                                         fontSize: 14,
          //                                         color: AppColors.txtGrey),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                         PopupMenuItem(
          //                           onTap: () async {

          //                           },
          //                           height: 35,
          //                           value: "Delete",
          //                           child: Row(
          //                             children: [
          //                               SvgPicture.asset(
          //                                 AppIcons.delete,
          //                                 height: 14,
          //                               ),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Delete",
          //                                 style: Theme.of(context)
          //                                     .textTheme
          //                                     .titleSmall!
          //                                     .copyWith(
          //                                         fontFamily:
          //                                             AppFont.fontMedium,
          //                                         fontSize: 14,
          //                                         color: AppColors.txtGrey),
          //                               ),
          //                             ],
          //                           ),
          //                         )
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediBrand} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Text(
          //                     medicine[index].brandName ?? "",
          //                     style: Theme.of(context).textTheme.titleMedium,
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediAbout} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].about ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediBeni} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].benefits ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.direction} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].directionForUse ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediDrug} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].drugDrugInteractions ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediUses} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].uses ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediSafety} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].safetyInformation ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediReview} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].ratings.toString(),
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediPrice} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].medicinePrice.toString(),
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     "${ConstString.mediDescription} : ",
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .titleMedium!
          //                         .copyWith(fontFamily: AppFont.fontMedium),
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       medicine[index].description ?? "",
          //                       style: Theme.of(context).textTheme.titleMedium,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //               const SizedBox(
          //                 height: 10,
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );
          return ListView.builder(
            itemCount: medicine.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.decsGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: AppColors.lineGrey)),
                  child: ExpansionTile(
                    backgroundColor: AppColors.decsGrey,
                    iconColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      medicine[index].genericName ?? "Unknown Medicine",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontFamily: AppFont.fontBold,
                          fontSize: 17,
                          color: AppColors.primaryColor),
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
                      medicineDetailTile(context, "Price:",
                          medicine[index].medicinePrice.toString()),
                      medicineDetailTile(
                          context, "Description:", medicine[index].description),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  showProgressDialogue(context);
                                  await controller
                                      .deleteMedicine(medicine[index].id!);
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
                            SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(() => MedicineAdd(
                                        medicine: medicine[index],
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
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
