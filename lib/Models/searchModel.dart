// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<SearchProduct> searchModel(String str) => List<SearchProduct>.from(json.decode(str).map((x) => SearchProduct.fromJson(x)));

String welcomeToJson(List<SearchProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchProduct {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  bool? isActive;
  String? title;
  String? foodPreference;
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
  String? stockQuantity;
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
  String? suggestion;
  String? cusine;
  int? createdBy;

  factory SearchProduct.fromJson(Map<String, dynamic> json) => SearchProduct(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    suggestion: json["suggestion"],
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
    "suggestion": suggestion,
    "cusine": cusine,
    "created_by": createdBy,
  };

  SearchProduct({
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
    this.suggestion,
    this.cusine,
    this.createdBy,
  });
}
