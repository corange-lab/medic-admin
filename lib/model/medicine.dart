class Medicine {
  String? id;
  String? medicineName;
  String? description;
  String? price;

  Medicine({this.id,
    this.medicineName,
    this.description,
    this.price,
  });

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineName = map['medicineName'];
    description = map['description'];
    price = map['price'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineName'] = medicineName;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}
