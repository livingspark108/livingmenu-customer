// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HomeM homeModel(String str) => HomeM.fromJson(json.decode(str));

String welcomeToJson(HomeM data) => json.encode(data.toJson());

class HomeM {
  int? locationId;
  double? latitude;
  double? longitude;
  int? cartItemsCount;
  double? cartItemsPrice;
  List<dynamic>? restaurantOffers;
  String? deliveryStatus;
  String? restaurantLocation;
  String? restaurantAddress;
  String? profilePic;
  String? restaurantOpenTime;
  String? restaurantCloseTime;

  HomeM({
    this.locationId,
    this.latitude,
    this.longitude,
    this.cartItemsCount,
    this.cartItemsPrice,
    this.restaurantOffers,
    this.deliveryStatus,
    this.restaurantLocation,
    this.restaurantAddress,
    this.profilePic,
    this.restaurantOpenTime,
    this.restaurantCloseTime,
  });

  factory HomeM.fromJson(Map<String, dynamic> json) => HomeM(
    locationId: json["location_id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    cartItemsCount: json["cart_items_count"],
    cartItemsPrice: json["cart_items_price"]?.toDouble(),
    restaurantOffers: List<dynamic>.from(json["restaurant_offers"].map((x) => x)),
    deliveryStatus: json["delivery_status"],
    restaurantLocation: json["restaurant_location"],
    restaurantAddress: json["restaurant_address"],
    profilePic: json["profile_pic"],
    restaurantOpenTime: json["restaurant_open_time"],
    restaurantCloseTime: json["restaurant_close_time"],
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "latitude": latitude,
    "longitude": longitude,
    "cart_items_count": cartItemsCount,
    "cart_items_price": cartItemsPrice,
    "restaurant_offers": List<dynamic>.from(restaurantOffers!.map((x) => x)),
    "delivery_status": deliveryStatus,
    "restaurant_location": restaurantLocation,
    "restaurant_address": restaurantAddress,
    "profile_pic": profilePic,
    "restaurant_open_time": restaurantOpenTime,
    "restaurant_close_time": restaurantCloseTime,
  };
}
