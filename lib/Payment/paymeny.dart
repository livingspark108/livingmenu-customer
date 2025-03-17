import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Gift/giftCard.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';
import 'package:living_menu_mobile/Wallet/livingMenuWallet.dart';

import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment>{
  late double w, h;
  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
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
                  SizedBox(height: h * 0.03,),
                  Text('Payment',
                    style: TextStyle(
                        fontFamily: 'Supreme_bold',
                        fontWeight: FontWeight.w700,
                        fontSize: fontSizes.fontSize24
                    ),
                  ),
                  SizedBox(height: h * 0.04,),
                  Text('Add Payment Method',
                    style: TextStyle(
                        fontFamily: 'Poppins_bold',
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize14
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.045),
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
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
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
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
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
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
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

                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
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
                                      child: Image.asset('assets/icons/paytm_icon.png',
                                        width: w * 0.06,
                                      ),
                                    ),
                                  ),
                                  Text('Paytm',
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

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(LivingMenuWallet()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.03),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: w * 0.09,
                                      // height: h * 0.05,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SvgPicture.asset('assets/icons/wallet.svg',
                                          width: w * 0.06,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Living Menu Wallet',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_semi_bold',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                          ),
                                        ),
                                        Text('₹500.25 INR',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize12,
                                            color: Color(0xFF7B7B7B),
                                            height: 1.5
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: w * 0.03),
                                  child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.03,),
                            Container(
                              width: w,
                              height: h * 0.001,
                              color: Color(0xFFF1F1F1),
                            )
                          ],
                        ),
                      ),
                    ),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(GiftCard()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Redeem Gift Card',
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
                    ),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferRestaurant()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.035),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [

                                    Text('Invite restaurant owner to earn credits',
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
                    ),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
