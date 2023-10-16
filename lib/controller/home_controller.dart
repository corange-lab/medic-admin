import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/user_model.dart';

class HomeController extends GetxController {
  Rx<UserModel?> loggedInUser = UserModel.newUser().obs;

  RxList<MedicineData> mediDataList = RxList<MedicineData>();

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
    ByteData data = await rootBundle.load("asset/medicineExcel.xlsx");
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      bool skipHeader = true;
      for (var row in excel.tables[table]!.rows) {
        if (skipHeader) {
          skipHeader = false;
          continue;
        }
        medicineDataList.add(MedicineData(
          id: row[0]?.value?.toString(),
          about: row[1]?.value?.toString(),
          brandName: row[2]?.value?.toString(),
          categoryId: row[3]?.value?.toString(),
          drugDrugInteractions: row[4]?.value?.toString(),
          image: row[5]?.value?.toString(),
          placeholderImage: row[6]?.value?.toString(),
          ratings: row[7]?.value?.toString(),
          genericName: row[8]?.value?.toString(),
          description: row[9]?.value?.toString(),
          benefits: row[10]?.value?.toString(),
          uses: row[11]?.value?.toString(),
          directionForUse: row[12]?.value?.toString(),
          safetyInformation: row[13]?.value?.toString(),
        ));
      }
    }
    return medicineDataList;
  }
}
