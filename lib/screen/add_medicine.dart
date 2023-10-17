import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_admin/controller/medicine_controller.dart';
import 'package:medic_admin/theme/colors.dart';
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ElevatedButton(
              onPressed: () {
                controller.addDataToFirestore();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
              child: Text("Add Medicine Data")),
        ),
        body: Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(clipBehavior: Clip.antiAliasWithSaveLayer,
              columnSpacing: 15,
              headingRowColor:
                  MaterialStateProperty.all(AppColors.tilePrimaryColor),
              columns: const [
                DataColumn(label: Text('id')),
                DataColumn(label: Text('about')),
                DataColumn(label: Text('brandName')),
                DataColumn(label: Text('categoryId')),
                DataColumn(label: Text('drugDrugInteractions')),
                DataColumn(label: Text('image')),
                DataColumn(label: Text('placeholderImage')),
                DataColumn(label: Text('ratings')),
                DataColumn(label: Text('genericName')),
                DataColumn(label: Text('description')),
                DataColumn(label: Text('benefits')),
                DataColumn(label: Text('uses')),
                DataColumn(label: Text('directionForUse')),
                DataColumn(label: Text('safetyInformation')),
              ],
              rows: controller.mediDataList.map((medicineData) {
                return DataRow(cells: [
                  DataCell(Text(
                    medicineData.id ?? "Id",
                    style: TextStyle(color: AppColors.darkPrimaryColor),
                  )),
                  DataCell(Text(medicineData.about ?? "About")),
                  DataCell(Text(medicineData.brandName ?? "Brand")),
                  DataCell(Text(medicineData.categoryId ?? "CategoryId")),
                  DataCell(Text(medicineData.drugDrugInteractions ??
                      "DrugInteraction")),
                  DataCell(Text(medicineData.image ?? "Image")),
                  DataCell(Text(
                      medicineData.placeholderImage ?? "Placeholder")),
                  DataCell(Text(medicineData.ratings ?? "Ratings")),
                  DataCell(
                      Text(medicineData.genericName ?? "GenericName")),
                  DataCell(
                      Text(medicineData.description ?? "Description")),
                  DataCell(Text(medicineData.benefits ?? "Benefits")),
                  DataCell(Text(medicineData.uses ?? "Uses")),
                  DataCell(
                      Text(medicineData.directionForUse ?? "Direction")),
                  DataCell(
                      Text(medicineData.safetyInformation ?? "Safety")),
                ]);
              }).toList()),
        )));
  }
}
