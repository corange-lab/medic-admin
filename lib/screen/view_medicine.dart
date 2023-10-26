import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';

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
          style:  Theme.of(context).textTheme.titleMedium!.copyWith(
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
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<MedicineData> medicine = snapshot.data!;
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            medicine[index].genericName!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontFamily: AppFont.fontBold,
                                    fontSize: 17,
                                    color: AppColors.primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediBrand} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Text(
                              medicine[index].brandName ?? "",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediAbout} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].about ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediBeni} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].benefits ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.direction} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].directionForUse ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediDrug} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].drugDrugInteractions ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediUses} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].uses ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediSafety} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].safetyInformation ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediReview} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].ratings.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${ConstString.mediDescription} : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontFamily: AppFont.fontMedium),
                            ),
                            Expanded(
                              child: Text(
                                medicine[index].description ?? "",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
}
