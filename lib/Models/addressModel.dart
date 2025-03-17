// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<AddressModel> welcomeFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String welcomeToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isActive;
  String? type;
  String? houseNo;
  String? floor;
  String? dropOffOptions;
  String? entryCode;
  bool? giftOptions;
  String? fullAddress;
  String? deliveryInstruction;
  String? mobileNo;
  String? lat;
  String? long;
  String? landmark;
  String? area;
  String? pincode;
  String? city;
  String? state;
  String? country;
  bool? isDefault;
  String? customer;
  int? user;

  AddressModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.isActive,
    this.type,
    this.houseNo,
    this.floor,
    this.dropOffOptions,
    this.entryCode,
    this.giftOptions,
    this.fullAddress,
    this.deliveryInstruction,
    this.mobileNo,
    this.lat,
    this.long,
    this.landmark,
    this.area,
    this.pincode,
    this.city,
    this.state,
    this.country,
    this.isDefault,
    this.customer,
    this.user,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isDeleted: json["is_deleted"],
    isActive: json["is_active"],
    type: json["type"],
    houseNo: json["house_no"],
    floor: json["floor"],
    dropOffOptions: json["drop_off_options"],
    entryCode: json["entry_code"],
    giftOptions: json["gift_options"],
    fullAddress: json["full_address"],
    deliveryInstruction: json["delivery_instruction"],
    mobileNo: json["mobile_no"],
    lat: json["lat"],
    long: json["long"],
    landmark: json["landmark"],
    area: json["area"],
    pincode: json["pincode"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    isDefault: json["default"],
    customer: json["customer"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_deleted": isDeleted,
    "is_active": isActive,
    "type": type,
    "house_no": houseNo,
    "floor": floor,
    "drop_off_options": dropOffOptions,
    "entry_code": entryCode,
    "gift_options": giftOptions,
    "full_address": fullAddress,
    "delivery_instruction": deliveryInstruction,
    "mobile_no": mobileNo,
    "lat": lat,
    "long": long,
    "landmark": landmark,
    "area": area,
    "pincode": pincode,
    "city": city,
    "state": state,
    "country": country,
    "default": isDefault,
    "customer": customer,
    "user": user,
  };
}




/*import 'dart:convert';
import 'dart:ui';

List<AddressModel> welcomeFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String welcomeToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  String? id;
  String? fullAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isDeleted;
  bool? isActive;
  String? type;
  String? houseNo;
  String? mobileNo;
  String? lat;
  String? long;
  String? landmark;
  String? area;
  String? pincode;
  String? city;
  String? state;
  String? country;
  bool? isDefault;
  String? customer;

  AddressModel({
    this.id,
    this.fullAddress,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.isActive,
    this.type,
    this.houseNo,
    this.mobileNo,
    this.lat,
    this.long,
    this.landmark,
    this.area,
    this.pincode,
    this.city,
    this.state,
    this.country,
    this.isDefault,
    this.customer,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    fullAddress: json['full_address'],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isDeleted: json["is_deleted"],
    isActive: json["is_active"],
    type: json["type"],
    houseNo: json["house_no"],
    mobileNo: json["mobile_no"],
    lat: json["lat"],
    long: json["long"],
    landmark: json["landmark"],
    area: json["area"],
    pincode: json["pincode"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    isDefault: json["default"],
    customer: json["customer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_address": fullAddress,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "is_deleted": isDeleted,
    "is_active": isActive,
    "type": type,
    "house_no": houseNo,
    "mobile_no": mobileNo,
    "lat": lat,
    "long": long,
    "landmark": landmark,
    "area": area,
    "pincode": pincode,
    "city": city,
    "state": state,
    "country": country,
    "default": isDefault,
    "customer": customer,
  };
}*/
