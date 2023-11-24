import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medic_admin/model/category_data.dart';
import 'package:medic_admin/model/discount_data_model.dart';
import 'package:medic_admin/model/medicine_data.dart';
import 'package:medic_admin/model/prescription_model.dart';
import 'package:medic_admin/model/review_data.dart';
import 'package:medic_admin/model/user_address.dart';
import 'package:medic_admin/model/user_model.dart';
import 'package:medic_admin/utils/firebase_utils.dart';

class OrderData {
  String? id;
  String? creatorId;
  String? addressId;
  String? reviewId;
  String? prescriptionId;
  Map<String, String> medicineId;
  String? discountId;
  String? categoryId;
  UserModel? userModel;
  UserAddress? userAddress;
  ReviewData? reviewData;
  PrescriptionData? prescriptionData;
  List<MedicineData>? medicineData;
  DiscountDataModel? discountData;
  CategoryData? categoryData;
  DateTime? orderDate;
  double? totalAmount;
  double? shippingCharge;
  double? discountAmount;
  int? quantity;
  String? orderStatus;

  OrderData({
    this.id,
    this.creatorId,
    this.addressId,
    this.reviewId,
    this.prescriptionId,
    required this.medicineId,
    this.discountId,
    this.categoryId,
    this.userModel,
    this.userAddress,
    this.reviewData,
    this.prescriptionData,
    this.medicineData,
    this.discountData,
    this.categoryData,
    this.orderDate,
    this.totalAmount,
    this.shippingCharge,
    this.discountAmount,
    this.quantity,
    this.orderStatus,
  });

  OrderData copyWith({
    String? id,
    String? creatorId,
    String? addressId,
    String? reviewId,
    String? prescriptionId,
    Map<String, String>? medicineId,
    String? discountId,
    String? categoryId,
    UserModel? userModel,
    UserAddress? userAddress,
    ReviewData? reviewData,
    PrescriptionData? prescriptionData,
    MedicineData? medicineData,
    DiscountDataModel? discountData,
    CategoryData? categoryData,
    DateTime? orderDate,
    double? totalAmount,
    double? shippingCharge,
    double? discountAmount,
    int? quantity,
    String? orderStatus,
  }) {
    return OrderData(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      addressId: addressId ?? this.addressId,
      reviewId: reviewId ?? this.reviewId,
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineId: medicineId ?? this.medicineId,
      discountId: discountId ?? this.discountId,
      categoryId: categoryId ?? this.categoryId,
      userModel: userModel ?? this.userModel,
      userAddress: userAddress ?? this.userAddress,
      reviewData: reviewData ?? this.reviewData,
      prescriptionData: prescriptionData ?? this.prescriptionData,
      medicineData: medicineData != null
          ? List<MedicineData>.from(medicineData as Iterable)
          : this.medicineData,
      discountData: discountData ?? this.discountData,
      categoryData: categoryData ?? this.categoryData,
      orderDate: orderDate ?? this.orderDate,
      totalAmount: totalAmount ?? this.totalAmount,
      shippingCharge: shippingCharge ?? this.shippingCharge,
      discountAmount: discountAmount ?? this.discountAmount,
      quantity: quantity ?? this.quantity,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorId': creatorId,
      'addressId': addressId,
      'reviewId': reviewId,
      'prescriptionId': prescriptionId,
      'medicineId': medicineId,
      'discountId': discountId,
      'categoryId': categoryId,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'shippingCharge': shippingCharge,
      'discountAmount': discountAmount,
      'quantity': quantity,
      'orderStatus': orderStatus,
    };
  }

  // factory OrderData.fromMap(Map<String, dynamic> map) {
  //   return OrderData(
  //     id: map['id'],
  //     creatorId: map['creatorId'],
  //     addressId: map['addressId'],
  //     reviewId: map['reviewId'],
  //     prescriptionId: map['prescriptionId'],
  //     medicineId: map['medicineId'],
  //     discountId: map['discountId'],
  //     categoryId: map['categoryId'],
  //   );
  // }

  factory OrderData.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> rawMedicineId = map['medicineId'] ?? {};
    Map<String, String> parsedMedicineId = rawMedicineId.map((key, value) {
      return MapEntry<String, String>(key, value.toString());
    });

    return OrderData(
      id: map['id'],
      creatorId: map['creatorId'],
      addressId: map['addressId'],
      reviewId: map['reviewId'],
      prescriptionId: map['prescriptionId'],
      medicineId: parsedMedicineId,
      discountId: map['discountId'],
      categoryId: map['categoryId'],
      orderDate: map['orderDate'] != null
          ? FirebaseUtils.timestampToDateTime(map['orderDate'])
          : null,
      totalAmount: map['totalAmount'],
      shippingCharge: map['shippingCharge'],
      discountAmount: map['discountAmount'],
      quantity: map['quantity'],
      orderStatus: map['orderStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderData.fromJson(String source) =>
      OrderData.fromMap(json.decode(source));

  factory OrderData.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return OrderData.fromMap(map);
  }
}
