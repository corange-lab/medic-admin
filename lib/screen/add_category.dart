import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/screen/category_add.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/app_font.dart';
import 'package:medic_admin/utils/string.dart';

class AddCategory extends StatelessWidget {
  MedicineController controller = Get.put(MedicineController());

  AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () {
            if (controller.categoryData.isEmpty) {
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
            } else if (controller.columnHeader2.isEmpty) {
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
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: DataTable(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    columnSpacing: 15,
                    headingRowColor:
                        MaterialStateProperty.all(AppColors.tilePrimaryColor),
                    columns: controller.columnHeader2
                        .map((header) => DataColumn(
                                label: Text(
                              header,
                              style: TextStyle(
                                  fontFamily: AppFont.fontMedium,
                                  color: AppColors.primaryColor,
                                  fontSize: 16),
                            )))
                        .toList(),
                    rows: controller.categoryData.map((categoryData) {
                      Map<String, dynamic> rowMap = categoryData.toMap();
                      return DataRow(
                          cells: controller.columnHeader2.map((header) {
                        return DataCell(Text(
                          rowMap[header]?.toString() ?? "N/A",
                          style: TextStyle(
                              color: AppColors.darkPrimaryColor,
                              fontFamily: AppFont.fontMedium),
                        ));
                      }).toList());
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 10,
          right: 0,left: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                    onPressed: () {
                      controller.importCategoryData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        fixedSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: Text("Pick File")),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => CategoryAdd());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text(ConstString.addCategory)),
              ),
            ],
          ),
        )
      ],
    );
    // return Scaffold(
    //   backgroundColor: AppColors.white,
    //   appBar: AppBar(
    //     title: Text(
    //       ConstString.addCategory,
    //       style: Theme.of(context)
    //           .textTheme
    //           .titleLarge!
    //           .copyWith(color: AppColors.white),
    //     ),
    //     backgroundColor: AppColors.primaryColor,
    //     centerTitle: true,
    //     actions: [
    //       IconButton(
    //           onPressed: () {
    //             controller.addCategoryDataToFirestore();
    //           },
    //           icon: Icon(
    //             Icons.import_export,
    //             color: AppColors.white,
    //           ))
    //     ],
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //         child: ElevatedButton(
    //             onPressed: () {
    //               controller.importCategoryData();
    //             },
    //             style: ElevatedButton.styleFrom(
    //                 backgroundColor: AppColors.primaryColor,
    //                 fixedSize: Size(200, 50),
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(40))),
    //             child: Text("Pick File")),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //         child: ElevatedButton(
    //             onPressed: () {
    //               Get.to(() => CategoryAdd());
    //             },
    //             style: ElevatedButton.styleFrom(
    //                 backgroundColor: AppColors.primaryColor,
    //                 fixedSize: const Size(200, 50),
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(40))),
    //             child: const Text(ConstString.addCategory)),
    //       ),
    //     ],
    //   ),
    // );
  }
}
