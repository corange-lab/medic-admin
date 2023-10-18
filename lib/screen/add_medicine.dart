import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';

class AddMedicine extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());

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
          actions: [
            IconButton(
                onPressed: () {
                  controller.addDataToFirestore();
                },
                icon: Icon(
                  Icons.import_export,
                  color: AppColors.white,
                ))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
              onPressed: () {
                controller.importMedicineData();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: Text("Pick File")),
        ),
        body: Obx(
          () {
            if (controller.mediDataList.isEmpty) {
              return Center(
                  child: Text(
                "No data available. Please pick a file to load the data.",
                style: TextStyle(
                    fontFamily: AppFont.fontMedium,
                    fontSize: 17,
                    color: AppColors.primaryColor),
              ));
            } else if (controller.columnHeader.isEmpty) {
              return Center(
                  child: Text(
                "No columns found in the loaded file. Please ensure the Excel file has headers.",
                style: TextStyle(
                    fontFamily: AppFont.fontMedium,
                    fontSize: 17,
                    color: AppColors.primaryColor),
              ));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                        // Convert value to string using toString()
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
        ));
  }
}
//DataRow(cells: [
//                       DataCell(Text(
//                         medicineData.id ?? "Id",
//                         style: TextStyle(color: AppColors.darkPrimaryColor),
//                       )),
//                       DataCell(Text(medicineData.about ?? "About")),
//                       DataCell(Text(medicineData.brandName ?? "Brand")),
//                       DataCell(Text(medicineData.categoryId ?? "CategoryId")),
//                       DataCell(Text(medicineData.drugDrugInteractions ??
//                           "DrugInteraction")),
//                       DataCell(Text(medicineData.image ?? "Image")),
//                       DataCell(
//                           Text(medicineData.placeholderImage ?? "Placeholder")),
//                       DataCell(Text(medicineData.ratings ?? "Ratings")),
//                       DataCell(Text(medicineData.genericName ?? "GenericName")),
//                       DataCell(Text(medicineData.description ?? "Description")),
//                       DataCell(Text(medicineData.benefits ?? "Benefits")),
//                       DataCell(Text(medicineData.uses ?? "Uses")),
//                       DataCell(
//                           Text(medicineData.directionForUse ?? "Direction")),
//                       DataCell(
//                           Text(medicineData.safetyInformation ?? "Safety")),
//                     ]);
