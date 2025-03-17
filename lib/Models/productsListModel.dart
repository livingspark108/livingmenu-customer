// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductsCategory productsListModel(String str) => ProductsCategory.fromJson(json.decode(str));

String welcomeToJson(ProductsCategory data) => json.encode(data.toJson());

class ProductsCategory {
  bool? status;
  String? message;
  List<Datum>? data;

  ProductsCategory({
    this.status,
    this.message,
    this.data,
  });

  factory ProductsCategory.fromJson(Map<String, dynamic> json) => ProductsCategory(
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
  List<Products>? products;

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
    products: List<Products>.from(json["products"].map((x) => Products.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Products {
  String? id;
  String? title;
  String? category;
  String? subCategory;
  String? cusine;
  String? foodPreference;
  String? type;
  bool? veg;
  bool? nonVeg;
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
  int? starRating;
  int? peopleCountRate;
  String? makingTime;
  String? image;
  String? createdBy;
  List<GroupedVariation>? groupedVariations;

  // GroupedVariations? groupedVariations;

  Products({
    this.id,
    this.title,
    this.category,
    this.subCategory,
    this.cusine,
    this.foodPreference,
    this.type,
    this.veg,
    this.nonVeg,
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
    this.starRating,
    this.peopleCountRate,
    this.makingTime,
    this.image,
    this.createdBy,
    this.groupedVariations,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    subCategory: json["sub_category"],
    cusine: json["cusine"],
    foodPreference: json["food_preference"],
    type: json["type"],
    veg: json["veg"],
    nonVeg: json["non-veg"],
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
    starRating: json["star_rating"],
    peopleCountRate: json["people_count_rate"],
    makingTime: json["making_time"],
    image: json["image"],
    createdBy: json["created_by"],
    groupedVariations: List<GroupedVariation>.from(json["grouped_variations"].map((x) => GroupedVariation.fromJson(x))),
    // groupedVariations: GroupedVariations.fromJson(json["grouped_variations"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "sub_category": subCategory,
    "cusine": cusine,
    "food_preference": foodPreference,
    "type": type,
    "veg": veg,
    "non-veg": nonVeg,
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
    "star_rating": starRating,
    "people_count_rate": peopleCountRate,
    "making_time": makingTime,
    "image": image,
    "created_by": createdBy,
    "grouped_variations": List<dynamic>.from(groupedVariations!.map((x) => x.toJson())),
    // "grouped_variations": groupedVariations!.toJson(),
  };
}

class GroupedVariation {
  String? type;
  List<Variation>? variations;

  GroupedVariation({
    this.type,
    this.variations,
  });

  factory GroupedVariation.fromJson(Map<String, dynamic> json) => GroupedVariation(
    type: json["type"],
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
  };
}

class Variation {
  String? id;
  String? name;
  double? price;
  int? stockQuantity;
  String? image;
  String? selectionType;

  Variation({
    this.id,
    this.name,
    this.price,
    this.stockQuantity,
    this.image,
    this.selectionType,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    stockQuantity: json["stock_quantity"],
    image: json["image"],
    selectionType: json["selection_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "stock_quantity": stockQuantity,
    "image": image,
    "selection_type": selectionType,
  };
}


/*class GroupedVariations {
  Map<String, List<Addon>>? addons;

  GroupedVariations({this.addons});

  factory GroupedVariations.fromJson(Map<String, dynamic> json) {
    // Parse all addon categories dynamically
    final parsedAddons = json.map<String, List<Addon>>((key, value) {
      if (value is List) {
        return MapEntry(
          key,
          List<Addon>.from(value.map((x) => Addon.fromJson(x))),
        );
      }
      return MapEntry(key, []); // Empty list if the value isn't a List
    });

    return GroupedVariations(addons: parsedAddons);
  }*/

 /* Map<String, dynamic> toJson() => {
    if (addons != null)
      ...addons!.map((key, value) => MapEntry(
        key,
        List<dynamic>.from(value.map((x) => x.toJson())),
      )),
  };
}*/

/*class GroupedVariations {
  List<Addon>? addon;
  List<Addon>? size;

  GroupedVariations({
    this.addon,
    this.size,
  });

  factory GroupedVariations.fromJson(Map<String, dynamic> json) => GroupedVariations(
    addon: json["addon"] == null ? [] : List<Addon>.from(json["addon"]!.map((x) => Addon.fromJson(x))),
    size: json["size"] == null ? [] : List<Addon>.from(json["size"]!.map((x) => Addon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addon": addon == null ? [] : List<dynamic>.from(addon!.map((x) => x.toJson())),
    "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x.toJson())),
  };
}*/

/*class Addon {
  String? id;
  String? name;
  double? price;
  int? stockQuantity;
  String? image;
  String? selectionType;

  Addon({
    this.id,
    this.name,
    this.price,
    this.stockQuantity,
    this.image,
    this.selectionType,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    stockQuantity: json["stock_quantity"],
    image: json["image"],
    selectionType: json["selection_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "stock_quantity": stockQuantity,
    "image": image,
    "selection_type": selectionType,
  };
}*/




/*final groupedVariations = GroupedVariations.fromJson(json);

// Get category names
if (groupedVariations.addons != null) {
List<String> categoryNames = groupedVariations.addons!.keys.toList();
print("Category Names: $categoryNames");
} else {
print("No addons available.");
}
}*/










/*enum MakingTime {
  THE_28_MIN
}

final makingTimeValues = EnumValues({
  "28 min": MakingTime.THE_28_MIN
});*/

/*enum PlateType {
  FLAT
}

final plateTypeValues = EnumValues({
  "Flat": PlateType.FLAT
});

enum Type {
  VEG
}

final typeValues = EnumValues({
  "Veg": Type.VEG
});*/

/*class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}*/
