import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';
import '../Constants/appStrings.dart';

class AddFund extends StatefulWidget {
  const AddFund({Key? key}) : super(key: key);

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund>{
  late double w, h;
  final TextEditingController amountController = TextEditingController();
  Razorpay? razorpay;
  ApiService apiService = ApiService();
  bool isLoading = false;


  void _handlePaymentSuccess(PaymentSuccessResponse response){
    // response.paymentId
    print('Payment Id--------------: ${response.data}');
    /*ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment successful"),
        duration: Duration(seconds: 3),
      ),
    );*/

    setState(() {
      isLoading = true;
    });

    apiService.addFundInWallet(
        response.paymentId ?? '', amountController.text, context
    ).then((value) {
      setState(() {
        isLoading = false;
      });
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
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: SvgPicture.asset('assets/icons/header_back.svg'),
                          ),
                        ),
                        SizedBox(height: h * 0.02,),
                        Text('Living Menu Wallet',
                          style: TextStyle(
                              fontFamily: 'Supreme_bold',
                              fontWeight: FontWeight.w700,
                              fontSize: fontSizes.fontSize24
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.015,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferRestaurant()));
                    },
                    child: Container(
                      width: w,
                      height: h * 0.038,
                      color: Color(0xFFFFD7FB),

                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/refer_friend.svg'),
                                SizedBox(width: w * 0.02,),
                                Text('Refer Restaurant',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12
                                  ),
                                ),
                                SizedBox(width: w * 0.01,),
                                Container(
                                  height: h * 0.004,
                                  width: w * 0.008,
                                  color: Colors.black,
                                ),
                                SizedBox(width: w * 0.01,),
                                Text('Get ₹1000',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset('assets/icons/right_arrow.svg',)
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            fontFamily: 'Pippins_regular',
                            color: Color(0xFF606060)
                          ),
                        ),
                        SizedBox(height: h * 0.01,),
                        Container(
                          height: h * 0.06,
                          width: w * 0.92,
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF1F1F1),
                            // color: Colors.red,
                          ),
                          child: TextFormField(
                            controller: amountController,
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              labelText: '500',
                              labelStyle: TextStyle(
                                // Custom style for the label
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black, // Label color
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

                       /* SizedBox(height: h * 0.035,),
                        Text('Payment Method',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizes.fontSize14,
                              fontFamily: 'Pippins_regular',
                              color: Colors.black
                          ),
                        ),*/









                        /*Container(
                          height: h * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.045),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.09,
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: SvgPicture.asset('assets/icons/credit_card.svg')
                                                ),
                                              ),
                                              Text('Credit/Debit Card',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.03),
                                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.035,),
                                      Container(
                                        width: w,
                                        height: h * 0.001,
                                        color: Color(0xFFF1F1F1),
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.035),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.09,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset('assets/icons/upi_icon.png',
                                                    width: w * 0.06,
                                                  ),
                                                ),
                                              ),
                                              Text('UPI',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.03),
                                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.035,),
                                      Container(
                                        width: w,
                                        height: h * 0.001,
                                        color: Color(0xFFF1F1F1),
                                      )
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.035),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.09,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset('assets/images/razorpay_icon.png',
                                                    width: w * 0.06,
                                                  ),
                                                ),
                                              ),
                                              Text('Razorpay',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.03),
                                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.035,),
                                      Container(
                                        width: w,
                                        height: h * 0.001,
                                        color: Color(0xFFF1F1F1),
                                      )
                                    ],
                                  ),
                                ),



                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.035),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.09,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset('assets/icons/google_pay_icon.png',
                                                    width: w * 0.06,
                                                  ),
                                                ),
                                              ),
                                              Text('Google Pay',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.03),
                                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.035,),
                                      Container(
                                        width: w,
                                        height: h * 0.001,
                                        color: Color(0xFFF1F1F1),
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.035),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: w * 0.09,
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset('assets/icons/phone_pay.png',
                                                    width: w * 0.06,
                                                  ),
                                                ),
                                              ),
                                              Text('Phone Pay',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.03),
                                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.035,),
                                      Container(
                                        width: w,
                                        height: h * 0.001,
                                        color: Color(0xFFF1F1F1),
                                      )
                                    ],
                                  ),
                                ),




                                SizedBox(height: h * 0.9,),
                              ],
                            ),
                          ),
                        )*/
                      ],
                    ),
                  ),










                  /*Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.045),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w * 0.09,
                                            child: Align(
                                                alignment: Alignment.topLeft,
                                                child: SvgPicture.asset('assets/icons/credit_card.svg')
                                            ),
                                          ),
                                          Text('Credit/Debit Card',
                                            style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03),
                                        child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.035,),
                                  Container(
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.035),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w * 0.09,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Image.asset('assets/icons/upi_icon.png',
                                                width: w * 0.06,
                                              ),
                                            ),
                                          ),
                                          Text('UPI',
                                            style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03),
                                        child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.035,),
                                  Container(
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  )
                                ],
                              ),
                            ),


                            Padding(
                              padding: EdgeInsets.only(top: h * 0.035),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w * 0.09,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Image.asset('assets/images/razorpay_icon.png',
                                                width: w * 0.06,
                                              ),
                                            ),
                                          ),
                                          Text('Razorpay',
                                            style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03),
                                        child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.035,),
                                  Container(
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  )
                                ],
                              ),
                            ),



                            Padding(
                              padding: EdgeInsets.only(top: h * 0.035),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w * 0.09,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Image.asset('assets/icons/google_pay_icon.png',
                                                width: w * 0.06,
                                              ),
                                            ),
                                          ),
                                          Text('Google Pay',
                                            style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03),
                                        child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.035,),
                                  Container(
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.035),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: w * 0.09,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Image.asset('assets/icons/phone_pay.png',
                                                width: w * 0.06,
                                              ),
                                            ),
                                          ),
                                          Text('Phone Pay',
                                            style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: w * 0.03),
                                        child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.035,),
                                  Container(
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  )
                                ],
                              ),
                            ),




                            SizedBox(height: h * 0.2,),
                          ],
                        ),
                      ),
                    ),
                  )*/












                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: h * 0.1,
                    width: w,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: h * 0.001,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.022),
                          child: GestureDetector(
                            onTap: () async{
                              // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(CartOrderPlace(latLong: _userLatLong)));
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              makePayment(
                                  double.parse(amountController.text) * 100,
                                  prefs.getString('firstName') ?? '',
                                  "Money Adding into wallet",
                                  prefs.getString('mobileNumber') ?? '',
                                  prefs.getString('userEmail') ?? '',
                              );
                            },
                            child: Container(
                              height: h * 0.055,
                              width: w,
                              decoration: BoxDecoration(
                                  color: Color(0xFF001FFF),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text(
                                  'Add Money',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.white
                                    // fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
