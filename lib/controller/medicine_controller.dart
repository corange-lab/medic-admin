import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/utils/utils.dart';

class MedicineController extends GetxController {
  TextEditingController medicineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ratinsController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController directionUseController = TextEditingController();
  TextEditingController drugInterController = TextEditingController();
  TextEditingController safetyInfoController = TextEditingController();
  TextEditingController usesController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();

  RxString preRequire = "".obs;

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');
  final CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('categories');

  RxList<MedicineData> mediDataList = RxList<MedicineData>();
  RxList<CategoryData> categoryData = RxList<CategoryData>();
  RxList<String> columnHeader = RxList<String>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  bool validateData() {
    if (medicineController.text.trim().isEmpty) {
      showInSnackBar("Please enter generic name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (brandController.text.trim().isEmpty) {
      showInSnackBar("Please enter brand name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (descriptionController.text.trim().isEmpty) {
      showInSnackBar("Please enter medicine description.",
          title: 'Required!', isSuccess: false);
      return false;
    }
    return true;
  }

  Stream<List<MedicineData>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<CategoryData>> fetchCategory() {
    var data = categoryRef.snapshots().map((event) {
      return event.docs.map((e) {
        return CategoryData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Future<void> addMedicineDataToFirestore() async {
    int dataAddCount = 0;
    for (MedicineData medicineData in mediDataList) {
      try {
        DocumentReference docRef = await medicineRef.add(medicineData.toMap());

        String newId = docRef.id;
        medicineData.id = newId;

        await docRef.update({'id': newId});

        dataAddCount++;
      } catch (e) {
        showInSnackBar("Data Added Error : $e",
            isSuccess: false, title: "The Medic");
      }
    }

    if (dataAddCount == mediDataList.length) {
      showInSnackBar("Data Added Succssfully",
          title: "The Medic", isSuccess: true);
    } else {
      showInSnackBar(
          '$dataAddCount out of ${mediDataList.length} medicines added successfully.',
          isSuccess: true,
          title: "The Medic");
    }
  }

  Future<void> addCategoryDataToFirestore() async {
    int dataAddCount = 0;
    for (CategoryData category in categoryData) {
      try {
        DocumentReference docRef = await medicineRef.add(category.toMap());

        String newId = docRef.id;
        category.id = newId;

        await docRef.update({'id': newId});

        dataAddCount++;
      } catch (e) {
        showInSnackBar("Data Added Error : $e",
            isSuccess: false, title: "The Medic");
      }
    }

    if (dataAddCount == categoryData.length) {
      showInSnackBar("Data Added Succssfully",
          title: "The Medic", isSuccess: true);
    } else {
      showInSnackBar(
          '$dataAddCount out of ${categoryData.length} category added successfully.',
          isSuccess: true,
          title: "The Medic");
    }
  }

  Future<Uint8List?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'ods']);

    if (result != null) {
      return result.files.single.bytes;
    } else {
      return null;
    }
  }

  importMedicineData() async {
    List<MedicineData> medicineDataList = [];

    Uint8List? bytes = await pickFile();

    if (bytes == null) {
      return [];
    }

    // ByteData data = await rootBundle.load("asset/medicineExcel.xlsx");
    // var bytes = excelFile.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      bool isHeaderRow = true;
      for (var row in excel.tables[table]!.rows) {
        if (isHeaderRow) {
          columnHeader.value =
              row.map((cell) => cell?.value?.toString() ?? '').toList();
          isHeaderRow = false;
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
    mediDataList.value = medicineDataList;
  }

  importCategoryData() async {
    List<CategoryData> categoryDataList = [];

    Uint8List? bytes = await pickFile();

    if (bytes == null) {
      return [];
    }

    // ByteData data = await rootBundle.load("asset/medicineExcel.xlsx");
    // var bytes = excelFile.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      bool isHeaderRow = true;
      for (var row in excel.tables[table]!.rows) {
        if (isHeaderRow) {
          columnHeader.value =
              row.map((cell) => cell?.value?.toString() ?? '').toList();
          isHeaderRow = false;
          continue;
        }
        categoryDataList.add(CategoryData(
            id: row[0]?.value?.toString(),
            name: row[1]?.value?.toString(),
            image: row[2]?.value?.toString(),
            sortNo: row[3]?.value));
      }
    }
    categoryData.value = categoryDataList;
  }
}
