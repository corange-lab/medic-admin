import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/user_model.dart';

class HomeController extends GetxController{
  Rx<UserModel?> loggedInUser = UserModel.newUser().obs;

  RxList mediDataList = [].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    mediDataList.value = await importMedicineData();
  }

  String getMobileNo() {
    if (loggedInUser.value?.mobileNo == null) {
      return '';
    }

    int? countryCode = loggedInUser.value?.countryCode;
    String? mobileNo = loggedInUser.value?.mobileNo ?? '';
    return '+${countryCode ?? ''} $mobileNo';
  }

  Future<List<MedicineData>> importMedicineData() async {
    List<MedicineData> medicineDataList = [];

    // Load the Excel file from the assets
    ByteData data = await rootBundle.load("assets/data.xlsx");
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        medicineDataList.add(MedicineData(
          id: row[0]?.toString(),
          about: row[1]?.toString(),
          brandName: row[2]?.toString(),
          categoryId: row[3]?.toString(),
          drugDrugInteractions: row[4]?.toString(),
          image: row[5]?.toString(),
          placeholderImage: row[6]?.toString(),
          ratings: row[7]?.toString(),
          genericName: row[8]?.toString(),
          description: row[9]?.toString(),
          benefits: row[10]?.toString(),
          uses: row[11]?.toString(),
          directionForUse: row[12]?.toString(),
          safetyInformation: row[13]?.toString(),
        ));
      }
    }

    return medicineDataList;
  }
}