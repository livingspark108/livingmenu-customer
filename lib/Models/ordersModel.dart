// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Orders ordersModel(String str) => Orders.fromJson(json.decode(str));

String welcomeToJson(Orders data) => json.encode(data.toJson());

class Orders {
  bool? status;
  String? message;
  Data? data;

  Orders({
    this.status,
    this.message,
    this.data,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  /*List<Apr>? nov;
  List<Apr>? dec;
  List<Apr>? mar;
  List<Apr>? apr;
  List<Apr>? oct;*/
  // List<Apr>? jan;
  // List<Apr>? feb;
  // List<Apr>? may;
  // List<Apr>? jun;
  // List<Apr>? jul;
  // List<Apr>? aug;
  // List<Apr>? sep;

  Map<String, List<Apr>> months;

  Data({
    required this.months
    /*this.nov,
    this.dec,
    this.mar,
    this.apr,
    this.oct,*/
    // this.jan,
    // this.feb,
    // this.may,
    // this.jun,
    // this.jul,
    // this.aug,
    // this.sep,
  });

  /*factory Data.fromJson(Map<String, dynamic> json) => Data(
    nov: List<Apr>.from(json["NOV"].map((x) => Apr.fromJson(x))),
    dec: List<Apr>.from(json["DEC"].map((x) => Apr.fromJson(x))),
    mar: List<Apr>.from(json["MAR"].map((x) => Apr.fromJson(x))),
    apr: List<Apr>.from(json["APR"].map((x) => Apr.fromJson(x))),
    oct: List<Apr>.from(json["OCT"].map((x) => Apr.fromJson(x))),
    // jan: List<Apr>.from(json["JAN"].map((x) => Apr.fromJson(x))),
    // feb: List<Apr>.from(json["FEB"].map((x) => Apr.fromJson(x))),
    // may: List<Apr>.from(json["MAY"].map((x) => Apr.fromJson(x))),
    // jun: List<Apr>.from(json["JUN"].map((x) => Apr.fromJson(x))),
    // jul: List<Apr>.from(json["JUL"].map((x) => Apr.fromJson(x))),
    // aug: List<Apr>.from(json["AUG"].map((x) => Apr.fromJson(x))),
    // sep: List<Apr>.from(json["SEP"].map((x) => Apr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "NOV": List<dynamic>.from(nov!.map((x) => x.toJson())),
    "DEC": List<dynamic>.from(dec!.map((x) => x.toJson())),
    "MAR": List<dynamic>.from(mar!.map((x) => x.toJson())),
    "APR": List<dynamic>.from(apr!.map((x) => x.toJson())),
    "OCT": List<dynamic>.from(oct!.map((x) => x.toJson())),
    // "JAN": List<dynamic>.from(jan!.map((x) => x.toJson())),
    // "FEB": List<dynamic>.from(feb!.map((x) => x.toJson())),
    // "MAY": List<dynamic>.from(may!.map((x) => x.toJson())),
    // "JUN": List<dynamic>.from(jun!.map((x) => x.toJson())),
    // "JUL": List<dynamic>.from(jul!.map((x) => x.toJson())),
    // "AUG": List<dynamic>.from(aug!.map((x) => x.toJson())),
    // "SEP": List<dynamic>.from(sep!.map((x) => x.toJson())),
  };*/

  factory Data.fromJson(Map<String, dynamic> json) {
    final monthKeys = ["NOV", "DEC", "MAR", "APR", "OCT", "SEP", "AUG", "JUL", "JUN", "MAY", "FEB", "JAN"];
    return Data(
      months: Map.fromEntries(
        monthKeys.map((key) => MapEntry(
          key,
          json[key] != null ? List<Apr>.from(json[key].map((x) => Apr.fromJson(x))) : [],
        )),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    for (var entry in months.entries) entry.key: List<dynamic>.from(entry.value.map((x) => x.toJson())),
  };

  // Utility method to get orders for a specific month
  List<Apr> getOrdersForMonth(String month) {
    return months[month.toUpperCase()] ?? [];
  }
}

class Apr {
  String? id;
  String? orderNo;
  String? tokenNo;
  double? appliedCommissionPer;
  String? discountType;
  double? discountAmount;
  double? commissionAmt;
  double? paymentGatwayCharge;
  double? totalPrice;
  double? subTotal;
  double? tip;
  bool? package;
  bool? markAsCredit;
  double? tax;
  double? originalPrice;
  String? authorizedBy;
  bool? isDiscount;
  String? feedback;
  String? feedbackFoodQuality;
  String? feedbackServiceQuality;
  String? feedbackStaffBehaviourQuality;
  bool? isKitchenRead;
  bool? isRestaurantRead;
  bool? buzz;
  double? creditAmt;
  double? advance;
  String? advanceType;
  String? deliveryBoyName;
  String? deliveryBoyLink;
  int? deliveryBoyOtp;
  double? deliveryBoyAmt;
  String? deliveryBoyMobileNo;
  String? gstType;
  String? type;
  String? deliveryType;
  String? deliveryDatetime;
  String? shippingTime;
  double? shippingAmt;
  String? confirmTime;
  String? instruction;
  bool? paymentStatus;
  bool? completeConfetti;
  bool? isClose;
  String? paymentMethod;
  String? chillyOrderNote;
  String? customerName;
  String? customerNumber;
  String? expectedDeliveryTime;
  String? dob;
  String? sugarOrderNote;
  String? status;
  String? onlineOrderStatus;
  String? liveStatus;
  int? noOfPerson;
  String? createdAt;

  Apr({
    this.id,
    this.orderNo,
    this.tokenNo,
    this.appliedCommissionPer,
    this.discountType,
    this.discountAmount,
    this.commissionAmt,
    this.paymentGatwayCharge,
    this.totalPrice,
    this.subTotal,
    this.tip,
    this.package,
    this.markAsCredit,
    this.tax,
    this.originalPrice,
    this.authorizedBy,
    this.isDiscount,
    this.feedback,
    this.feedbackFoodQuality,
    this.feedbackServiceQuality,
    this.feedbackStaffBehaviourQuality,
    this.isKitchenRead,
    this.isRestaurantRead,
    this.buzz,
    this.creditAmt,
    this.advance,
    this.advanceType,
    this.deliveryBoyName,
    this.deliveryBoyLink,
    this.deliveryBoyOtp,
    this.deliveryBoyAmt,
    this.deliveryBoyMobileNo,
    this.gstType,
    this.type,
    this.deliveryType,
    this.deliveryDatetime,
    this.shippingTime,
    this.shippingAmt,
    this.confirmTime,
    this.instruction,
    this.paymentStatus,
    this.completeConfetti,
    this.isClose,
    this.paymentMethod,
    this.chillyOrderNote,
    this.customerName,
    this.customerNumber,
    this.expectedDeliveryTime,
    this.dob,
    this.sugarOrderNote,
    this.status,
    this.onlineOrderStatus,
    this.liveStatus,
    this.noOfPerson,
    this.createdAt,
  });

  factory Apr.fromJson(Map<String, dynamic> json) => Apr(
    id: json["id"],
    orderNo: json["order_no"],
    tokenNo: json["token_no"],
    appliedCommissionPer: json["applied_commission_per"],
    discountType: json["discount_type"],
    discountAmount: json["discount_amount"],
    commissionAmt: json["commission_amt"]?.toDouble(),
    paymentGatwayCharge: json["payment_gatway_charge"],
    totalPrice: json["total_price"]?.toDouble(),
    subTotal: json["sub_total"],
    tip: json["tip"],
    package: json["package"],
    markAsCredit: json["mark_as_credit"],
    tax: json["tax"]?.toDouble(),
    originalPrice: json["original_price"],
    authorizedBy: json["authorized_by"],
    isDiscount: json["is_discount"],
    feedback: json["feedback"],
    feedbackFoodQuality: json["feedback_food_quality"],
    feedbackServiceQuality: json["feedback_service_quality"],
    feedbackStaffBehaviourQuality: json["feedback_staff_behaviour_quality"],
    isKitchenRead: json["is_kitchen_read"],
    isRestaurantRead: json["is_restaurant_read"],
    buzz: json["buzz"],
    creditAmt: json["credit_amt"],
    advance: json["advance"],
    advanceType: json["advance_type"],
    deliveryBoyName: json["delivery_boy_name"],
    deliveryBoyLink: json["delivery_boy_link"],
    deliveryBoyOtp: json["delivery_boy_otp"],
    deliveryBoyAmt: json["delivery_boy_amt"],
    deliveryBoyMobileNo: json["delivery_boy_mobile_no"],
    gstType: json["gst_type"],
    type: json["type"],
    deliveryType: json["delivery_type"],
    deliveryDatetime: json["delivery_datetime"],
    shippingTime: json["shipping_time"],
    shippingAmt: json["shipping_amt"],
    confirmTime: json["confirm_time"],
    instruction: json["instruction"],
    paymentStatus: json["payment_status"],
    completeConfetti: json["complete_confetti"],
    isClose: json["is_close"],
    paymentMethod: json["payment_method"],
    chillyOrderNote: json["chilly_order_note"],
    customerName: json["customer_name"],
    customerNumber: json["customer_number"],
    expectedDeliveryTime: json["expected_delivery_time"],
    dob: json["dob"],
    sugarOrderNote: json["sugar_order_note"],
    status: json["status"],
    onlineOrderStatus: json["online_order_status"],
    liveStatus: json["live_status"],
    noOfPerson: json["no_of_person"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "token_no": tokenNo,
    "applied_commission_per": appliedCommissionPer,
    "discount_type": discountType,
    "discount_amount": discountAmount,
    "commission_amt": commissionAmt,
    "payment_gatway_charge": paymentGatwayCharge,
    "total_price": totalPrice,
    "sub_total": subTotal,
    "tip": tip,
    "package": package,
    "mark_as_credit": markAsCredit,
    "tax": tax,
    "original_price": originalPrice,
    "authorized_by": authorizedBy,
    "is_discount": isDiscount,
    "feedback": feedback,
    "feedback_food_quality": feedbackFoodQuality,
    "feedback_service_quality": feedbackServiceQuality,
    "feedback_staff_behaviour_quality": feedbackStaffBehaviourQuality,
    "is_kitchen_read": isKitchenRead,
    "is_restaurant_read": isRestaurantRead,
    "buzz": buzz,
    "credit_amt": creditAmt,
    "advance": advance,
    "advance_type": advanceType,
    "delivery_boy_name": deliveryBoyName,
    "delivery_boy_link": deliveryBoyLink,
    "delivery_boy_otp": deliveryBoyOtp,
    "delivery_boy_amt": deliveryBoyAmt,
    "delivery_boy_mobile_no": deliveryBoyMobileNo,
    "gst_type": gstType,
    "type": type,
    "delivery_type": deliveryType,
    "delivery_datetime": deliveryDatetime,
    "shipping_time": shippingTime,
    "shipping_amt": shippingAmt,
    "confirm_time": confirmTime,
    "instruction": instruction,
    "payment_status": paymentStatus,
    "complete_confetti": completeConfetti,
    "is_close": isClose,
    "payment_method": paymentMethod,
    "chilly_order_note": chillyOrderNote,
    "customer_name": customerName,
    "customer_number": customerNumber,
    "expected_delivery_time": expectedDeliveryTime,
    "dob": dob,
    "sugar_order_note": sugarOrderNote,
    "status": status,
    "online_order_status": onlineOrderStatus,
    "live_status": liveStatus,
    "no_of_person": noOfPerson,
    "created_at": createdAt,
  };
}
