import 'package:medic_admin/utils/firebase_utils.dart';

class PrescriptionData {
  String? id;
  String? title;
  List<dynamic>? images;
  DateTime? uploadTime;
  String? userId;
  List<String>? medicineId;
  bool? isApproved;

  PrescriptionData(this.id, this.title, this.images, this.uploadTime,
      this.userId, this.isApproved, this.medicineId);

  PrescriptionData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    images = map['images'];
    uploadTime = map['uploadTime'] != null
        ? FirebaseUtils.timestampToDateTime(map['uploadTime'])
        : null;
    userId = map['userId'];
    medicineId = map['medicineId'];
    isApproved = map['isApproved'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['images'] = images;
    data['uploadTime'] = uploadTime;
    data['userId'] = userId;
    data['medicineId'] = medicineId;
    data['isApproved'] = isApproved;
    return data;
  }
}
