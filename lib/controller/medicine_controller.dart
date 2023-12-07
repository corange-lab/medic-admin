import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/theme/colors.dart';
import 'package:medic_admin/utils/assets.dart';
import 'package:medic_admin/utils/utils.dart';
import 'package:medic_admin/widgets/pick_image.dart';

class MedicineController extends GetxController {
  TextEditingController categoryController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController ratinsController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController discountIdController = TextEditingController();
  TextEditingController directionUseController = TextEditingController();
  TextEditingController drugInterController = TextEditingController();
  TextEditingController safetyInfoController = TextEditingController();
  TextEditingController usesController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();

  PickImageController pickImageController = Get.put(PickImageController());

  RxString preRequire = "Yes".obs;

  RxString type = "".obs;

  List<String> typeList = ["Popular", "Recommended"];

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');
  final CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('categories');

  RxList<MedicineData> mediDataList = RxList<MedicineData>();
  RxList<CategoryData> categoryData = RxList<CategoryData>();
  RxList<String> columnHeader = RxList<String>();
  RxList<String> columnHeader2 = RxList<String>();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  List popularColorList = [
    AppColors.listColor1,
    AppColors.listColor2,
    AppColors.listColor3,
    AppColors.listColor1,
    AppColors.listColor4,
  ];

  List medicineImageList = [
    AppImages.medicineBox1,
    AppImages.medicineBox2,
    AppImages.medicineBox3,
  ];

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
    } else if (priceController.text.trim().isEmpty) {
      showInSnackBar("Please enter medicine price.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (pickImageController.image == null) {
      showInSnackBar("Please select medicine image");
      return false;
    }
    return true;
  }

  bool validateCategoryData() {
    if (categoryController.text.trim().isEmpty) {
      showInSnackBar("Please enter category name.",
          title: 'Required!', isSuccess: false);
      return false;
    } else if (pickImageController.categoryImage == null) {
      showInSnackBar("Please select category image");
      return false;
    }
    return true;
  }

  clearController() {
    medicineController.clear();
    descriptionController.clear();
    priceController.clear();
    aboutController.clear();
    ratinsController.clear();
    brandController.clear();
    categoryIdController.clear();
    discountIdController.clear();
    directionUseController.clear();
    drugInterController.clear();
    safetyInfoController.clear();
    usesController.clear();
    benefitsController.clear();
  }

  Stream<List<MedicineData>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<MedicineData>> fetchMedicines() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<MedicineData>> fetchPopularMedicine() {
    var data = medicineRef
        .where('ratings', isGreaterThanOrEqualTo: "3.5")
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return MedicineData.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  deleteMedicine(String medicineId) async {
    DocumentReference docRef = medicineRef.doc(medicineId);

    await docRef.delete().then((value) {
      Get.back();
      showInSnackBar("Medicine Data Deleted Successfully!",
          isSuccess: true, title: "The Medic");
    }).onError((error, stackTrace) {
      showInSnackBar("Error : $error");
    });
  }

  deleteCategory(String categoryId) async {
    DocumentReference docRef = categoryRef.doc(categoryId);

    await docRef.delete().then((value) {
      Get.back();
      showInSnackBar("Category Data Deleted Successfully!",
          isSuccess: true, title: "The Medic");
    }).onError((error, stackTrace) {
      showInSnackBar("Error : $error");
    });
  }

  updateMedicine(MedicineData medicine) async {
    DocumentReference medicineDoc = medicineRef.doc(medicine.id);

    await medicineDoc.update(medicine.toMap()).then((value) {
      Get.back();
      showInSnackBar("Medicine Data Updated Successfully!", isSuccess: true);
      clearController();
    }).onError((error, stackTrace) {
      showInSnackBar("Error : $error");
    });
  }

  updateCategory(CategoryData category) async {
    DocumentReference categoryDoc = categoryRef.doc(category.id);

    await categoryDoc.update(category.toMap()).then((value) {
      Get.back();
      showInSnackBar("Category Data Updated Successfully!", isSuccess: true);
      categoryController.clear();
    }).onError((error, stackTrace) {
      showInSnackBar("Error : $error");
    });
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

  storeMedicineData(MedicineData medicine) async {
    await medicineRef.doc(medicine.id).set(medicine.toMap()).then((value) {
      Get.back();
      showInSnackBar("Medicine Added Successfully",
          isSuccess: true, title: "The Medic");
      clearController();
    }).catchError((error) {
      print("Error : $error");
    });
  }

  storeCategoryData(CategoryData category) async {
    await categoryRef.doc(category.id).set(category.toMap()).then((value) {
      Get.back();
      showInSnackBar("Category Added Successfully",
          isSuccess: true, title: "The Medic");
      categoryController.clear();
    }).catchError((error) {
      print("Error : $error");
    });
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
        type: FileType.custom,
        allowedExtensions: ['xls', 'xlsx', 'ods', 'xml', 'xlsm']);

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
          id: row.isNotEmpty ? _parseString(row[0]?.value) : "",
          about: row.length > 1 ? _parseString(row[1]?.value) : "",
          brandName: row.length > 2 ? _parseString(row[2]?.value) : "",
          genericName: row.length > 3 ? _parseString(row[3]?.value) : "",
          medicinePrice: row.length > 4 ? _parseInt(row[4]?.value) : 0,
          quantity: row.length > 5 ? _parseInt(row[5]?.value) : 0,
          image: row.length > 6 ? _parseString(row[6]?.value) : "",
          placeholderImage: row.length > 7 ? _parseString(row[7]?.value) : "",
          categoryId: row.length > 8 ? _parseString(row[8]?.value) : "",
          discountId: row.length > 9 ? _parseString(row[9]?.value) : "",
          drugDrugInteractions:
              row.length > 10 ? _parseString(row[10]?.value) : "",
          ratings: row.length > 11 ? _parseString(row[11]?.value) : "",
          description: row.length > 12 ? _parseString(row[12]?.value) : "",
          benefits: row.length > 13 ? _parseString(row[13]?.value) : "",
          uses: row.length > 14 ? _parseString(row[14]?.value) : "",
          directionForUse: row.length > 15 ? _parseString(row[15]?.value) : "",
          safetyInformation:
              row.length > 16 ? _parseString(row[16]?.value) : "",
          prescriptionRequire:
              row.length > 17 ? _parseBool(row[17]?.value) : false,
          type: row.length > 18 ? _parseString(row[18]?.value) : "",
        ));
      }
    }
    mediDataList.value = medicineDataList;
  }

  int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is int) {
      return value;
    }
    return 0;
  }

  String _parseString(dynamic value) {
    return value?.toString() ?? "";
  }

  bool _parseBool(dynamic value) {
    if (value is String) {
      return value.toLowerCase() == 'true';
    } else if (value is bool) {
      return value;
    }
    return false;
  }

  // bool _parseBool(dynamic value) {
  //   if (value == null) return false;
  //   return value.toLowerCase() == 'yes';
  // }

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
          columnHeader2.value =
              row.map((cell) => cell?.value?.toString() ?? '').toList();
          isHeaderRow = false;
          continue;
        }
        print(
            'Row Data: ${row.map((cell) => cell?.value?.toString() ?? 'is').toList()}');
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
