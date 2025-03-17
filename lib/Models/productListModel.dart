// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

ProductCategory productListModel(String str) => ProductCategory.fromJson(json.decode(str));

String welcomeToJson(ProductCategory data) => json.encode(data.toJson());

class ProductCategory {
  bool? status;
  String? message;
  List<Datum>? data;

  ProductCategory({
    this.status,
    this.message,
    this.data,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  String? image;
  List<Product>? products;

  Datum({
    this.id,
    this.title,
    this.image,
    this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  String? id;
  String? title;
  double? price;
  double? fullPrice;
  double? halfPrice;
  String? shortDescription;
  String? productImage;

  Product({
     this.id,
     this.title,
     this.price,
     this.fullPrice,
     this.halfPrice,
     this.shortDescription,
     this.productImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    fullPrice: json["full_price"]?.toDouble(),
    halfPrice: json["half_price"],
    shortDescription: json["short_description"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "full_price": fullPrice,
    "half_price": halfPrice,
    "short_description": shortDescription,
    "product_image": productImage,
  };
}
