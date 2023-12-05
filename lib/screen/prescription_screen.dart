import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medic_admin/controller/prescription_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/prescription_model.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class PrescriptionScreen extends StatelessWidget {
  PrescriptionController controller = Get.put(PrescriptionController());

  PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.fetchPrescriptionsWithDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SizedBox(
            height: 35,
            width: 35,
            child: CupertinoActivityIndicator(
                color: AppColors.primaryColor, radius: 15),
          ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "${snapshot.error}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<PrescriptionData> prescriptionList = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: prescriptionList.length,
              itemBuilder: (context, index) {
                var prescriptionInfo = prescriptionList[index];
                var documentId = prescriptionInfo.id;
                var indexWithInDoc = prescriptionInfo.prescriptionIndex;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.lineGrey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${prescriptionList[index].title}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontBold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: prescriptionList[index].images?.length,
                              itemBuilder: (context, ind) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: AppColors.tilePrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      imageUrl: prescriptionList[index]
                                              .images?[ind] ??
                                          '',
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.error);
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              SizedBox(
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
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Prescription By : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontFamily: AppFont.fontRegular,
                                      ),
                                ),
                                Text(
                                  prescriptionList[index]
                                          .userId!
                                          .split("+")
                                          .last ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontFamily: AppFont.fontMedium,
                                          fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                                onPressed: () async {
                                  showModelSheet(
                                      context,
                                      prescriptionList,
                                      indexWithInDoc!,
                                      prescriptionList[index].documentId!);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    fixedSize: const Size(150, 40),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: const Text("Select Medicines")),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Medicines : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontFamily: AppFont.fontRegular,
                                      ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${prescriptionList[index].medicineList ?? ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontFamily: AppFont.fontMedium,
                                            fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                prescriptionList[index].isApproved!
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          String userId =
                                              prescriptionList[index].userId!;
                                          String prescriptionId =
                                              prescriptionList[index].id!;
                                          await controller.approvePrescription(
                                              userId.split("+").first,
                                              prescriptionId,
                                              false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.red,
                                            fixedSize: const Size(100, 40),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: const Text("Denied"))
                                    : ElevatedButton(
                                        onPressed: () async {
                                          String userId =
                                              prescriptionList[index].userId!;
                                          String prescriptionId =
                                              prescriptionList[index].id!;
                                          await controller.approvePrescription(
                                              userId.split("+").first,
                                              prescriptionId,
                                              true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.green,
                                            fixedSize: const Size(100, 40),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: const Text("Approved")),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
              child: Text(
            "No Data Found",
          ));
        }
      },
    );
  }

  void showModelSheet(
      BuildContext context, List precriptionList, int index, String docId) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Select Medicines : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 20),
                            ),
                            Expanded(
                              child: Text(
                                "${controller.selectMedicineIdList}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 20,
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontMedium),
                              ),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: StreamBuilder(
                      stream: controller.fetchMedicine(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CupertinoActivityIndicator(
                            color: AppColors.primaryColor,
                          );
                        } else if (snapshot.hasData) {
                          List<MedicineData> medicineList = snapshot.data!;

                          List<String> medicineNameList = [];

                          for (var medicine in medicineList) {
                            medicineNameList.add(medicine.genericName!);
                          }

                          return Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: AppColors.lineGrey, width: 2)),
                              child: DropdownButton(
                                itemHeight: kMinInteractiveDimension,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 13),
                                hint: Text(
                                  "Select Medicine",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 14,
                                          color: AppColors.txtGrey),
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 130),
                                  child: SvgPicture.asset(AppIcons.arrowDown),
                                ),
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(10),
                                onChanged: (value) {
                                  controller.selectedMedicine.value = value!;
                                  if (!controller.selectMedicineIdList
                                      .contains(value)) {
                                    controller.selectMedicineIdList.add(value);
                                  }
                                },
                                items: medicineNameList.isNotEmpty
                                    ? medicineList.map((MedicineData medicine) {
                                        return DropdownMenuItem<String>(
                                          value: medicine.id,
                                          child: Text(
                                            medicine.genericName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(fontSize: 13),
                                          ),
                                        );
                                      }).toList()
                                    : null,
                                value: medicineNameList.contains(
                                        controller.selectedMedicine.value)
                                    ? controller.selectedMedicine.value
                                    : null, // Handle a value not in list scenario
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        showProgressDialogue(context);
                        controller.addMedicineToPrescriptionItem(
                            docId, index, controller.selectMedicineIdList);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          fixedSize: const Size(300, 40),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text("Submit")),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
