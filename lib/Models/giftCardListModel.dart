// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<CardList> giftCardListModel(String str) => List<CardList>.from(json.decode(str).map((x) => CardList.fromJson(x)));

String welcomeToJson(List<CardList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardList {
  String? code;
  double? amount;
  bool? isRedeemed;
  String? createdAt;

  CardList({
    this.code,
    this.amount,
    this.isRedeemed,
    this.createdAt,
  });

  factory CardList.fromJson(Map<String, dynamic> json) => CardList(
    code: json["code"],
    amount: json["amount"],
    isRedeemed: json["is_redeemed"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "amount": amount,
    "is_redeemed": isRedeemed,
    "created_at": createdAt,
  };
}
