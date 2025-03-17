import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Gift/giftPurchaseSuccessful.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class BuyGiftCard extends StatefulWidget {
  const BuyGiftCard({super.key});

  @override
  State<BuyGiftCard> createState() => _BuyGiftCard();
}

class _BuyGiftCard extends State<BuyGiftCard>{
  late double w, h;
  Razorpay? razorpay;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController receiversNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  ApiService apiService = ApiService();

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    // response.paymentId
    print('Payment Id--------------: ${response.paymentId}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment successful"),
        duration: Duration(seconds: 3),
      ),
    );
    final amount = double.parse(amountController.text.trim());
    final name = receiversNameController.text.trim();
    final phone = mobileController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    apiService.buyGiftCard(context, amount.toString(), name, email, phone, message, response.paymentId?? '').then((value){
      final response = value;
      final data = jsonDecode(response.body);
      print('GIFT RESPONSE--------------->>${data}');
      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(GiftPurchaseSuccessful(name: name, phone: phone, amount: amount.toString(), code: data['gift_card_code'])));
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error--------------: ${response.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response!.message ?? 'Payment failed'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External wallet payment"),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // makePayment(200*100, 'Yatendra', 'Testing Payment', '917737374941', 'yatendrasen@gmail.com');
  }

  void makePayment(double amount, String name, String message, String contact, String email) async {
    var options = {
      'key': AppStrings.RAZORPAY_API_KEY_TEST,
      'amount': amount,
      'name': name,
      'description': message,
      'profile':{'contact': contact, 'email': email},
    };

    try {
      razorpay?.open(options);
    }catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.07, left: w * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/icons/header_back.svg')
                          ),
                          GestureDetector(
                            onTap: (){
                              // Navigator.push(context, route)
                            },
                            child: Container(
                              width: w * 0.22,
                              // height: h * 0.1,
                              child: Text('Reedem',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: h * 0.03,),
                      Text('Gift Card',
                        style: TextStyle(
                          fontSize: fontSizes.fontSize24,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Supreme_bold',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.015,),

                Container(
                  width: w,
                  height: h * 0.001,
                  color: Color(0xFFF1F1F1),
                ),
                SizedBox(height: h * 0.02,),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enter Amount',
                        style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins_regular',
                          color: Color(0xFF606060),
                        ),
                      ),
                      SizedBox(height: h * 0.01,),
                      Container(
                        height: h * 0.05,
                        width: w,
                        alignment: Alignment.center,
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFF1F1F1),
                          // color: Colors.red,
                        ),
                        child: TextFormField(
                          cursorColor: Colors.red,
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            labelText: '500',
                            labelStyle: TextStyle(
                              // Custom style for the label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF606060), // Label color
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F1F1),
                            isCollapsed: true,
                            border: InputBorder.none,
                          ).copyWith(isDense: true),
                        ),
                      ),

                      SizedBox(height: h * 0.02,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              amountController.text = '1200';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xFFF1F1F1),
                                      width: w * 0.002
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                child: Text('+1200',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Pippins_regular',
                                      color: Color(0xFF606060)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          GestureDetector(
                            onTap: (){
                              amountController.text = '1000';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xFFF1F1F1),
                                      width: w * 0.002
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                child: Text('+1000',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Pippins_regular',
                                      color: Color(0xFF606060)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          GestureDetector(
                            onTap: (){
                              amountController.text = '500';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xFFF1F1F1),
                                      width: w * 0.002
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                child: Text('+500',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Pippins_regular',
                                      color: Color(0xFF606060)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          GestureDetector(
                            onTap: (){
                              amountController.text = '100';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xFFF1F1F1),
                                      width: w * 0.002
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                child: Text('+100',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Pippins_regular',
                                      color: Color(0xFF606060)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.02,),

                    ],
                  ),
                ),
                Container(
                  width: w,
                  height: h * 0.001,
                  color: Color(0xFFF1F1F1),
                ),
                SizedBox(height: h * 0.02,),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF0F2FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015, bottom: h * 0.015),
                              child: Text(AppStrings.BUY_GIFT_CARD_MSG,
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_regular',
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                    
                          SizedBox(height: h * 0.02,),
                          Text('Enter Complete Details',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: h * 0.01,),
                          Text("Receiver's Name",
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Container(
                            height: h * 0.05,
                            width: w,
                            alignment: Alignment.center,
                            padding:
                            EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF1F1F1),
                              // color: Colors.red,
                            ),
                            child: TextFormField(
                              controller: receiversNameController,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: 'Full name / Nick name',
                                labelStyle: TextStyle(
                                  // Custom style for the label
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060), // Label color
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F1F1),
                                isCollapsed: true,
                                border: InputBorder.none,
                              ).copyWith(isDense: true),
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Text("Email",
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Container(
                            height: h * 0.05,
                            width: w,
                            alignment: Alignment.center,
                            padding:
                            EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF1F1F1),
                              // color: Colors.red,
                            ),
                            child: TextFormField(
                              controller: emailController,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: 'xyz@gmail.com',
                                labelStyle: TextStyle(
                                  // Custom style for the label
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060), // Label color
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F1F1),
                                isCollapsed: true,
                                border: InputBorder.none,
                              ).copyWith(isDense: true),
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Text("Phone",
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Container(
                            height: h * 0.05,
                            width: w,
                            alignment: Alignment.center,
                            padding:
                            EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF1F1F1),
                              // color: Colors.red,
                            ),
                            child: TextFormField(
                              controller: mobileController,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: 'Add Mobile Number',
                                labelStyle: TextStyle(
                                  // Custom style for the label
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060), // Label color
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F1F1),
                                isCollapsed: true,
                                border: InputBorder.none,
                              ).copyWith(isDense: true),
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Text("Add a Message",
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                    
                          SizedBox(height: h * 0.01,),
                          Container(
                            height: h * 0.1,
                            width: w,
                            alignment: Alignment.center,
                            padding:
                            EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFF1F1F1),
                              // color: Colors.red,
                            ),
                            child: TextFormField(
                              controller: messageController,
                              maxLines: null,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: '',
                                labelStyle: TextStyle(
                                  // Custom style for the label
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060), // Label color
                                ),
                                filled: true,
                                fillColor: Color(0xFFF1F1F1),
                                isCollapsed: true,
                                border: InputBorder.none,
                              ).copyWith(isDense: true),
                            ),
                          ),
                  
                          SizedBox(height: h * 0.2,),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        height: h * 0.001,
                        color: Color(0xFFF1F1F1),
                      ),

                      SizedBox(height: h * 0.02,),

                      GestureDetector(
                        onTap: (){
                          print('Receiver: ${receiversNameController.text}');

                          if(amountController.text.trim().isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter amount.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else if(receiversNameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter receiver's name."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else if(emailController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter email."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else if(mobileController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter phone number."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else if(mobileController.text.trim().length < 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter valid phone number."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else if(messageController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter message."),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else {
                            final amount = double.parse(amountController.text.trim()) * 100;
                            final name = receiversNameController.text.trim();
                            final phone = mobileController.text.trim();
                            final email = emailController.text.trim();
                            final message = messageController.text.trim();
                            makePayment(amount, name, message, phone, email);
                          }


                        },
                        child: Container(
                          width: w * 0.9,
                          height: h * 0.06,
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Continue',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02,),
                    ],
                  ),
                )
            )
          ],
        ),
    );
  }

}
