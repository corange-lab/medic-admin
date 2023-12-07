import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/screen/medicine_add.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/widgets/app_dialogue.dart';

class MedicineDetails extends StatelessWidget {
  MedicineData? medicine;

  MedicineController controller = Get.put(MedicineController());

  MedicineDetails({super.key, this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          ConstString.medicineDetail,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppFont.fontMedium),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${medicine!.genericName}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontFamily: AppFont.fontBold,
                    fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediBrand} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      "${medicine!.brandName}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontSemiBold,
                          fontSize: 17),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => MedicineAdd(
                                  medicine: medicine,
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: const Size(80, 30),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Text(
                            "Edit",
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
                          onPressed: () async {
                            showProgressDialogue(context);
                            await controller.deleteMedicine(medicine!.id!);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              fixedSize: const Size(80, 30),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Text(
                            "Delete",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediPrice} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      "${medicine!.medicinePrice}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontSemiBold,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediDescription} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.description ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediAbout} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.about ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediBeni} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine?.benefits ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediDirection} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.directionForUse ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediDrug} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.drugDrugInteractions ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediUses} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.uses ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: AppColors.txtGrey.withOpacity(0.2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ConstString.mediSafety} : ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.txtGrey,
                        fontFamily: AppFont.fontMedium,
                        fontSize: 16),
                  ),
                  Expanded(
                    child: Text(
                      medicine!.safetyInformation ?? "N/A",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.primaryColor,
                          fontFamily: AppFont.fontMedium,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
