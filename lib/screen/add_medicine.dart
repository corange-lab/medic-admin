import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/screen/medicine_add.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';
import 'package:medic_admin/utils/utils.dart';

class AddMedicine extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () {
            if (controller.mediDataList.isEmpty) {
              return Container(
                height: 600,
                child: Center(
                    child: Text(
                  "No data available. Please pick a file to load the data.",
                  style: TextStyle(
                      fontFamily: AppFont.fontMedium,
                      fontSize: 17,
                      color: AppColors.primaryColor),
                )),
              );
            } else if (controller.columnHeader.isEmpty) {
              return Container(
                height: 600,
                child: Center(
                    child: Text(
                  "No columns found in the loaded file. Please ensure the Excel file has headers.",
                  style: TextStyle(
                      fontFamily: AppFont.fontMedium,
                      fontSize: 17,
                      color: AppColors.primaryColor),
                )),
              );
            } else {
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: DataTable(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  columnSpacing: 15,
                  headingRowColor:
                      MaterialStateProperty.all(AppColors.tilePrimaryColor),
                  columns: controller.columnHeader
                      .map((header) => DataColumn(
                              label: Text(
                            header,
                            style: TextStyle(
                                fontFamily: AppFont.fontMedium,
                                color: AppColors.primaryColor,
                                fontSize: 16),
                          )))
                      .toList(),
                  rows: controller.mediDataList.map((medicineData) {
                    Map<String, dynamic> rowMap = medicineData.toMap();
                    return DataRow(
                        cells: controller.columnHeader.map((header) {
                      return DataCell(Text(
                        rowMap[header]?.toString() ?? "N/A",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.darkPrimaryColor,
                            fontFamily: AppFont.fontMedium),
                      ));
                    }).toList());
                  }).toList(),
                ),
              );
            }
          },
        ),
        Positioned(
            bottom: 10,
            right: 30,
            child: GestureDetector(
              onTap: () {
                if (controller.mediDataList.isNotEmpty) {
                  controller.addMedicineDataToFirestore();
                } else {
                  showInSnackBar("Please select any data!",
                      isSuccess: false, title: "The Medic");
                }
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primaryColor),
                child: Icon(
                  Icons.import_export,
                  color: AppColors.white,
                ),
              ),
            )),
        Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.importMedicineData();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: const Text(ConstString.pickFile)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => MedicineAdd());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: const Text(ConstString.addMedicine)),
                ),
              ],
            ))
      ],
    );
    // return Scaffold(
    //   backgroundColor: AppColors.white,
    //   appBar: AppBar(
    //     title: Text(
    //       ConstString.addMedicine,
    //       style: Theme
    //           .of(context)
    //           .textTheme
    //           .titleLarge!
    //           .copyWith(color: AppColors.white),
    //     ),
    //     backgroundColor: AppColors.primaryColor,
    //     centerTitle: true,
    //     actions: [
    //
    //     ],
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    // );
  }
}
