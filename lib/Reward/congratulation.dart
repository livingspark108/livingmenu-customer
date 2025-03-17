import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:living_menu_mobile/Wallet/livingMenuWallet.dart';

import '../Constants/appFontSizes.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({super.key});

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation>{
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset('assets/images/congratulations.png',
                height: h * 0.37,
                width: w,
                fit: BoxFit.fill,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.06),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.01, bottom: h * 0.01),
                            child: SvgPicture.asset('assets/icons/header_back_white.svg'),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.025,),
                  Center(
                    child: Text('WOOOHOOOOO!!!!',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_regular',
                        color: Colors.white,
                        height: 1
                      ),
                    ),
                  ),
                  Center(
                    child: Text('₹20',
                      style: TextStyle(
                          // fontSize: 80,
                          fontSize: fontSizes.fontSize80,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins_regular',
                          height: 1.1,
                          color: Color(0xFFF6C52F),
                        shadows: [
                          Shadow(
                            color: Color(0xFFFCAC00),  // Outer glow color
                            offset: Offset(0, 0),
                            blurRadius: 100, // Larger blur for a soft glow
                          ),
                          /*Shadow(
                            color: Color(0xFFFCAC00).withOpacity(0.6), // Inner glow color
                            offset: Offset(0, 0),
                            blurRadius: 10,
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Credited to LM Wallet',
                      style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins_regular',
                          color: Colors.white,
                          height: 1
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(MainScreen()), (route) => false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                            child: Row(
                              children: [
                                Text('Order Food Now',
                                  style: TextStyle(
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: w * 0.02,),
                                SvgPicture.asset('assets/icons/arrow_insert.svg')
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.03,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(LivingMenuWallet()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                            child: Row(
                              children: [
                                Text('Open Wallet',
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )

                ],
              )
            ],
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.015, right: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w * 0.5,
                    child: Text('Get ₹1000 for referring to a restaurant',
                      style: TextStyle(
                          fontSize: fontSizes.fontSize16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins_regular',
                          color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                      )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.015),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/send.svg'),
                          SizedBox(width: w * 0.04,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Share your code with a restaurant.',
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(AppStrings.CONGRATULATION_MSG1,
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060),
                                  ),
                                ),
                                SizedBox(height: h * 0.01,),
                                Row(
                                  children: [
                                    Container(
                                      height: h * 0.045,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color(0xFFF1F1F1)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/share_link_small.svg'),
                                            SizedBox(width: w * 0.02,),
                                            Text('Share Link',
                                              style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins_semi_bold',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.015,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: h * 0.02,),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.015),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/ask_img.svg'),
                          SizedBox(width: w * 0.04,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ask them to signup through your link',
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(AppStrings.CONGRATULATION_MSG2,
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060),
                                  ),
                                ),

                                SizedBox(height: h * 0.015,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),



                  SizedBox(height: h * 0.02,),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.015),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset('assets/icons/rupees_icon_black.svg'),
                          SizedBox(width: w * 0.04,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Get ₹1000 in your LM Wallet',
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                  ),
                                ),
                                Text(AppStrings.CONGRATULATION_MSG3,
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060),
                                  ),
                                ),

                                SizedBox(height: h * 0.015,)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )




                ],
              ),
            ),

          ),
          

        ],
      ),
    );
  }

}
