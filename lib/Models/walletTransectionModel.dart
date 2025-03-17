// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

WalletTransactions walletTransactionModel(String str) => WalletTransactions.fromJson(json.decode(str));

String welcomeToJson(WalletTransactions data) => json.encode(data.toJson());

class WalletTransactions {
  double? walletBalance;
  List<Transaction>? recentTransactions;
  List<Transaction>? allTransactions;

  WalletTransactions({
    this.walletBalance,
    this.recentTransactions,
    this.allTransactions,
  });

  factory WalletTransactions.fromJson(Map<String, dynamic> json) => WalletTransactions(
    walletBalance: json["wallet_balance"],
    recentTransactions: List<Transaction>.from(json["recent_transactions"].map((x) => Transaction.fromJson(x))),
    allTransactions: List<Transaction>.from(json["all_transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet_balance": walletBalance,
    "recent_transactions": List<dynamic>.from(recentTransactions!.map((x) => x.toJson())),
    "all_transactions": List<dynamic>.from(allTransactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  String? transactionId;
  double? amount;
  String? type;
  String? date;

  Transaction({
    this.transactionId,
    this.amount,
    this.type,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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
