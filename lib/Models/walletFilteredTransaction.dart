// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<FilteredTransaction> walletFilteredTransaction(String str) => List<FilteredTransaction>.from(json.decode(str).map((x) => FilteredTransaction.fromJson(x)));

String welcomeToJson(List<FilteredTransaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilteredTransaction {
  String? transactionId;
  double? amount;
  String? type;
  String? date;

  FilteredTransaction({
    this.transactionId,
    this.amount,
    this.type,
    this.date,
  });

  factory FilteredTransaction.fromJson(Map<String, dynamic> json) => FilteredTransaction(
    transactionId: json["transaction_id"],
    amount: json["amount"],
    type: json["type"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "amount": amount,
    "type": type,
    "date": date,
  };
}
