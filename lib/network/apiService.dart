import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Models/addressModel.dart';
import 'package:living_menu_mobile/Models/giftCardListModel.dart';
import 'package:living_menu_mobile/Models/homeModel.dart';
import 'package:living_menu_mobile/Models/ordersModel.dart';
import 'package:living_menu_mobile/Models/productsListModel.dart';
import 'package:living_menu_mobile/Models/savedProductModel.dart';
import 'package:living_menu_mobile/Models/searchModel.dart';
import 'package:living_menu_mobile/Models/walletFilteredTransaction.dart';
import 'package:living_menu_mobile/Models/walletTransectionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Models/productListModel.dart';

class ApiService {
  // static const String baseUrl = "http://142.93.210.192:8003/api/customer/";
  static const String baseUrl = "http://142.93.210.192:8003/mobile_api/";
  static const String imageBaseUrl = "http://142.93.210.192:8003";


  /// Generic method to make POST requests
  Future<Map<String, dynamic>> _postRequest({
    required String endpoint,
    required Map<String, String> body,
  }) async {
    final String url = "$baseUrl$endpoint";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print('ResponseData: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else {
        throw Exception(
          "Failed to process request. Status code: ${response.statusCode}, Message: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("An error occurred while processing request: $e");
    }
  }

  /*Future<http.Response> _postRequest({
    required String endpoint,
    required Map<String, String> body,
  }) async {
    final String url = "$baseUrl$endpoint";
    final Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print('ResponseData: ${response.body}');

      if (response.statusCode == 200) {
        // Return the raw response object
        return response;
      } else {
        // Throw an exception for non-200 status codes
        throw Exception(
          "Failed to process request. Status code: ${response.statusCode}, Message: ${response.body}",
        );
      }
    } catch (e) {
      // Handle and rethrow exceptions for debugging
      throw Exception("An error occurred while processing request: $e");
    }
  }*/


  Future<Map<String, dynamic>> _getRequest({
    required String endpoint,
    Map<String, String>? queryParams, // Nullable queryParams
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final Uri url = Uri.parse("$baseUrl$endpoint").replace(
      queryParameters: queryParams?.isEmpty ?? true ? null : queryParams,
    );
    final token = prefs.getString('authToken');
    final Map<String, String> headers = {
      "Authorization": "Token $token",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Failed to process request. Status code: ${response.statusCode}, Message: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("An error occurred while processing request: $e");
    }
  }



  /// Login user
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
    required String device_id,
    required String fcm_token,
  }) async {
    final Map<String, String> body = {

      "username": username,
      "password": password,
      "device_id": device_id,
      "fcm_token": fcm_token
    };
    return await _postRequest(endpoint: "login/", body: body);
  }

  // Get product list with category


  /// Send OTP
  Future sendOtp(String mobileNum, String restaurantId) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + 'send-otp/'),
          headers: {
            // "Content-Type": "application/json",
          }, body: {
            "phone_number": mobileNum,
            "restaurant_id": restaurantId,
          });
      print(response.body);
      if (response.statusCode == 200) {
        // ProductCategory productData = productListModel(response.body);
        print(response);
        return response;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future forgotPasswordSendOtp(String mobileNum, String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.post(
          Uri.parse(baseUrl + 'forgot_password/'),
          headers: {
            // "Content-Type": "application/json",
          }, body: {
        "phone_number": mobileNum,
        "restaurant_id": restaurantId,
      });
      print(response.body);
      if (response.statusCode == 200) {
        // ProductCategory productData = productListModel(response.body);
        print(response);
        return response;
      } else {
        return response;
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future verifyForgotPassword(String mobileNum, String otp, String newPassword, String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.post(
          Uri.parse(baseUrl + 'verify_and_set_password/'),
          headers: {
            // "Content-Type": "application/json",
          }, body: {
        "phone_number": mobileNum,
        "otp": otp,
        "new_password": newPassword,
        // "restaurant_id": restaurantId
      });
      print(response.body);
      if (response.statusCode == 200) {
        // ProductCategory productData = productListModel(response.body);
        print(response);
        return response;
      } else {
        return response;
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }


  /// Send OTP
  Future verifyOtp(String mobileNum, String otp, String password, String firstName) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + 'verify-otp/'),
          headers: {
            // "Content-Type": "application/json",
          }, body: {
        "phone_number": mobileNum,
        "otp": otp,
        "password": password,
        "first_name": firstName
      });
      print(response.body);
      if (response.statusCode == 200) {
        // ProductCategory productData = productListModel(response.body);
        print(response);
        return response;
      } else {
        final data = json.decode(response.body);
        return response;
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getRewardsList(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.get(
        Uri.parse(baseUrl + 'rewards/'),
        headers: {
          "Authorization": "Token ${token}",
          // "Content-Type": "application/json",
        }, );
      print(response.body);
      if (response.statusCode == 200) {

        return response;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getStarted(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.get(
          Uri.parse(baseUrl + 'get-started/?restaurant_id=${AppStrings.RESTAURANT_ID}'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, );
      print(response.body);
      if (response.statusCode == 200) {

        return response;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }


  Future getHomeDetail(String restaurantId, String lat, String long) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'home-api/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
            "lat": lat,
          "long": long,
          "restaurant_id": restaurantId,
        });
      print(response.body);
      if (response.statusCode == 200) {
        HomeM homeM = homeModel(response.body);
        print(homeM);
        return homeM;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }


  Future getProduct(String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'products-by-category/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
      }, body: {
        "restaurant_id": restaurantId,
      });
      print(response.body);
      if (response.statusCode == 200) {
        ProductsCategory productsData = productsListModel(response.body);
        print(productsData);
        return productsData;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future saveProduct(String productId, String restaurantId, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'save-product/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
            "product_id": productId,
        "restaurant_id": restaurantId,
      });
      print(response.body);
      if (response.statusCode == 201) {
        // ProductCategory productData = productListModel(response.body);
        // print(productData);
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        return response;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getSavedProduct(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(baseUrl + 'get-saved-products/'),
        headers: {
          "Authorization": "Token ${token}"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("--------$data");
        // message(data["message"].toString());
        List<SavedProductModel> savedProductModel = savedProduct(response.body);
        print('0000000000-----------> ${savedProductModel}');
        return savedProductModel;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future searchProduct(BuildContext context, String title, String restaurantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'search/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
            "title": title,
        "restaurant_id": restaurantId,
      });
      print(response.body);
      if (response.statusCode == 200) {
        List<SearchProduct> searchProduct = searchModel(response.body);
        print(searchProduct);
        return searchProduct;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(baseUrl + 'get-address/'),
        headers: {
          "Authorization": "Token ${token}"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("--------$data");
        // message(data["message"].toString());
        List<AddressModel> addressModel = welcomeFromJson(response.body);
        print('0000000000-----------> ${addressModel}');
        print('0000000000 Length-----------> ${addressModel.length}');
        return addressModel;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future editAddress(BuildContext context, String isDeleted, String isActive,
      String type, String houseNo, String mobileNum, String lat, String long,
      String landmark, String area, String pinCode, String city, String state,
      String country, String isDefault, String customerId, String floor, String dropOff,
      String entryCode, String isGift, String fullAddress, String deliveryInstruction,
      String userId, String addressId) async {
    try {
      print('TYPE----${type}');
      print('HouseNo----${houseNo}');
      print('mobile----${mobileNum}');
      print('lat----${lat}');
      print('long----${long}');
      print('landmark----${landmark}');
      print('area----${area}');
      print('pinCode----${pinCode}');
      print('city----${city}');
      print('state----${state}');
      print('country----${country}');
      print('customerId----${customerId}');
      print('floor----${floor}');
      print('dropOff----${dropOff}');
      print('entryCode----${entryCode}');
      print('isGift----${isGift}');
      print('fullAddress----${fullAddress}');
      print('deliveryInstruction----${deliveryInstruction}');
      print('userId----${userId}');
      print('addressId----${addressId}');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.put(
          Uri.parse(baseUrl + 'edit-address/${addressId}'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
        "is_deleted": isDeleted,
        "is_active": isActive,
        "type": type,
        "house_no": houseNo,
        "floor": floor,
        "drop_off_options": dropOff,
        "entry_code": entryCode,
        "gift_options": isGift,
        "full_address": fullAddress,
        "delivery_instruction": deliveryInstruction,
        "mobile_no": mobileNum,
        "lat": lat,
        "long": long,
        "landmark": landmark,
        "area": area,
        "pincode": pinCode,
        "city": city,
        "state": state,
        "country": country,
        "default": isDefault,
        "customer": customerId,
        "user": userId,
      });
      print(response.body);
      print('STATUS CODE--------${response.statusCode}');
      if (response.statusCode == 200) {
        return response;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future addAddress(BuildContext context, String isDeleted, String isActive,
      String type, String houseNo, String mobileNum, String lat, String long,
      String landmark, String area, String pinCode, String city, String state,
      String country, String isDefault, String customerId, String floor, String dropOff,
      String entryCode, String isGift, String fullAddress, String deliveryInstruction, String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'add-address/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
        "is_deleted": isDeleted,
        "is_active": isActive,
        "type": type,
        "house_no": houseNo,
        "floor": floor,
        "drop_off_options": dropOff,
        "entry_code": entryCode,
        "gift_options": isGift,
        "full_address": fullAddress,
        "delivery_instruction": deliveryInstruction,
        "mobile_no": mobileNum,
        "lat": lat,
        "long": long,
        "landmark": landmark,
        "area": area,
        "pincode": pinCode,
        "city": city,
        "state": state,
        "country": country,
        "default": isDefault,
        "customer": customerId,
        "user": userId,
      });
      print(response.body);
      if (response.statusCode == 201) {
        // ProductCategory productData = productListModel(response.body);
        // print(productData);
        // final data = json.decode(response.body);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(data["message"]),
        //     duration: Duration(seconds: 3),
        //   ),
        // );
        print('MESSAGE--------------------------->>>>>${response.body}');
        return response;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future addFundInWallet(String paymentId, String amount, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'wallet/add-fund/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          }, body: {
        "transaction_id": paymentId,
        "amount": amount,
      });
      print(response.body);
      if (response.statusCode == 201) {
        // ProductCategory productData = productListModel(response.body);
        // print(productData);
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        print('MESSAGE--------------------------->>>>>${data['message']}');
        return response;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getWalletTransaction(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'wallet/overview/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          },);
      print(response.body);
      if (response.statusCode == 200) {
        WalletTransactions walletTransactions = walletTransactionModel(response.body);
        print(walletTransactions);

        return walletTransactions;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getWalletFilteredTransaction(BuildContext context, String month, String year) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
        Uri.parse(baseUrl + 'wallet/filter/'),
        headers: {
          "Authorization": "Token ${token}",
          // "Content-Type": "application/json",
        },
        body: {
          'month': month,
          'year': year
        }
      );
      print(response.body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("--------$data");
        // message(data["message"].toString());
        List<FilteredTransaction> filteredTransaction = walletFilteredTransaction(response.body);
        print('0000000000-----------> ${filteredTransaction}');
        return filteredTransaction;
        /*WalletTransactions walletTransactions = walletTransactionModel(response.body);
        print(walletTransactions);

        return walletTransactions;*/
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future buyGiftCard(BuildContext context, String amount, String receiversName,
      String email, String phoneNumber, String message, String transactionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
        Uri.parse(baseUrl + 'gift-card/buy/'),
        headers: {
          "Authorization": "Token ${token}",
          // "Content-Type": "application/json",
        },
      body: {
          "amount": amount,
        "receivers_name": receiversName,
        "email": email,
        "phone_number": phoneNumber,
        "message": message,
        "transaction_id": transactionId
      });
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return response;
       /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getGiftCards(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final response = await http.get(
        Uri.parse(baseUrl + 'gift-card/list/'),
        headers: {
          "Authorization": "Token ${token}"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("--------$data");
        // message(data["message"].toString());
        List<CardList> cardList = giftCardListModel(response.body);
        print('0000000000-----------> ${cardList}');
        return cardList;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future giftCarsRedeem(BuildContext context, String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'gift-card/redeem/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          },
          body: {
            "code": code,
          });
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return response;
        /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future changePassword(BuildContext context, String oldPassword, String newPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.post(
          Uri.parse(baseUrl + 'change-password/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          },
          body: {
            "old_password": oldPassword,
            "new_password": newPassword,
          });
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return response;
        /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future getAllOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> ${token}');
      final response = await http.get(
          Uri.parse(baseUrl + 'get-order/'),
          headers: {
            "Authorization": "Token ${token}",
            // "Content-Type": "application/json",
          },);
      print(response.body);
      if (response.statusCode == 200) {
        Orders orders = ordersModel(response.body);
        print(orders);
        return orders;
      } else {
        final data = json.decode(response.body);
        // message(data["message"].toString());
      }
    } catch (e) {
      print(e);
    }
  }


  Future addToCart(BuildContext context, String productId, String title, double price,
      String size, List<String> addons, int quantity) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      print('TOKEN ------------> $token');

      // JSON data to send
      final Map<String, dynamic> requestBody = {
        "product": {
          "id": productId,
          "title": title,
          "price": price
        },
        "size": size,
        "addons": addons,
        "quantity": quantity
      };

      // Encode the data to JSON
      final String jsonBody = json.encode(requestBody);

      // Make the POST request
      final response = await http.post(
        Uri.parse(baseUrl + 'save-product/'),
        headers: {
          "Authorization": "Token $token",
          "Content-Type": "application/json", // Set content type to JSON
        },
        body: jsonBody, // Send the JSON-encoded body
      );

      print(response.body);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        return response;
      } else {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }





}





// HOW TO USE POST SERVICE
/*
void main() async {
  final apiService = ApiService();

  try {
    // Send OTP
    final otpResponse = await apiService.sendOtp(
      name: "John Doe",
      mobileNumber: "1234567890",
      otp: "1234",
      password: "securePassword",
    );
    print("Send OTP Response: $otpResponse");

    // Login
    final loginResponse = await apiService.login(
      mobileNumber: "1234567890",
      password: "securePassword",
    );
    print("Login Response: $loginResponse");

    // Fetch User Profile
    final profileResponse = await apiService.fetchUserProfile(
      userId: "123",
    );
    print("Profile Response: $profileResponse");

    // Update User Profile
    final updateResponse = await apiService.updateUserProfile(
      userId: "123",
      name: "John Updated",
      email: "john.updated@example.com",
    );
    print("Update Response: $updateResponse");

  } catch (e) {
    print("Error: $e");
  }
  }*/



// HOW TO USE GET REQUEST

/*void main() async {
  final apiService = ApiService();

  try {
    // Fetch User Profile (GET request)
    final profileResponse = await apiService.fetchUserProfile(
      userId: "123",
    );
    print("Profile Response: $profileResponse");

  } catch (e) {
    print("Error: $e");
  }
}*/
