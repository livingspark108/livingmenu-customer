// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<SavedProductModel> savedProduct(String str) => List<SavedProductModel>.from(json.decode(str).map((x) => SavedProductModel.fromJson(x)));

String welcomeToJson(List<SavedProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedProductModel {
  int? id;
  int? user;
  Product? product;
  DateTime? savedAt;

  SavedProductModel({
    this.id,
    this.user,
    this.product,
    this.savedAt,
  });

  factory SavedProductModel.fromJson(Map<String, dynamic> json) => SavedProductModel(
    id: json["id"],
    user: json["user"],
    product: Product.fromJson(json["product"]),
    savedAt: DateTime.parse(json["saved_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "product": product!.toJson(),
    "saved_at": savedAt,
  };
}

class Product {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isDeleted;
  bool? isActive;
  String? title;
  dynamic? foodPreference;
  String? type;
  String? plateType;
  double? price;
  double? fullPrice;
  double? halfPrice;
  double? gst;
  String? shortDescription;
  String? jainDescription;
  bool? customizable;
  List<dynamic>? additional;
  int? stockQuantity;
  bool? inventory;
  bool? isAdminApprove;
  bool? isSpicyLevel;
  bool? isSugarLevel;
  bool? isFavourite;
  bool? jain;
  bool? variation;
  String? productImage;
  String? category;
  String? subCategory;
  String? cusine;
  int? createdBy;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.isActive,
    this.title,
    this.foodPreference,
    this.type,
    this.plateType,
    this.price,
    this.fullPrice,
    this.halfPrice,
    this.gst,
    this.shortDescription,
    this.jainDescription,
    this.customizable,
    this.additional,
    this.stockQuantity,
    this.inventory,
    this.isAdminApprove,
    this.isSpicyLevel,
    this.isSugarLevel,
    this.isFavourite,
    this.jain,
    this.variation,
    this.productImage,
    this.category,
    this.subCategory,
    this.cusine,
    this.createdBy,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isDeleted: json["is_deleted"],
    isActive: json["is_active"],
    title: json["title"],
    foodPreference: json["food_preference"],
    type: json["type"],
    plateType: json["plate_type"],
    price: json["price"],
    fullPrice: json["full_price"],
    halfPrice: json["half_price"],
    gst: json["gst"],
    shortDescription: json["short_description"],
    jainDescription: json["jain_description"],
    customizable: json["customizable"],
    additional: List<dynamic>.from(json["additional"].map((x) => x)),
    stockQuantity: json["stock_quantity"],
    inventory: json["inventory"],
    isAdminApprove: json["is_admin_approve"],
    isSpicyLevel: json["is_spicy_level"],
    isSugarLevel: json["is_sugar_level"],
    isFavourite: json["is_favourite"],
    jain: json["jain"],
    variation: json["variation"],
    productImage: json["product_image"],
    category: json["category"],
    subCategory: json["sub_category"],
    cusine: json["cusine"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_deleted": isDeleted,
    "is_active": isActive,
    "title": title,
    "food_preference": foodPreference,
    "type": type,
    "plate_type": plateType,
    "price": price,
    "full_price": fullPrice,
    "half_price": halfPrice,
    "gst": gst,
    "short_description": shortDescription,
    "jain_description": jainDescription,
    "customizable": customizable,
    "additional": List<dynamic>.from(additional!.map((x) => x)),
    "stock_quantity": stockQuantity,
    "inventory": inventory,
    "is_admin_approve": isAdminApprove,
    "is_spicy_level": isSpicyLevel,
    "is_sugar_level": isSugarLevel,
    "is_favourite": isFavourite,
    "jain": jain,
    "variation": variation,
    "product_image": productImage,
    "category": category,
    "sub_category": subCategory,
    "cusine": cusine,
    "created_by": createdBy,
  };
}
