import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Reward/referralStatus.dart';

import '../Constants/appFontSizes.dart';

class ReferRestaurant extends StatefulWidget {
  const ReferRestaurant({super.key});

  @override
  State<ReferRestaurant> createState() => _ReferRestaurantState();
}

class _ReferRestaurantState extends State<ReferRestaurant>{
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.07, left: w * 0.05),
                child: SvgPicture.asset('assets/icons/header_back.svg'),
              ),
            ),
            SizedBox(height: h * 0.03,),
            Container(
              width: w,
              height: h * 0.001,
              color: Color(0xFFF1F1F1),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.02,),
                  Center(
                    child: Image.asset('assets/images/gift_box.png',
                      width: w * 0.32,
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  Text('Refer & Get',
                    style: TextStyle(
                      fontSize: fontSizes.fontSize24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Supreme_bold',
                      color: Colors.black
                    ),
                  ),
                  Text('₹1000',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Supreme_bold',
                        color: Color(0xFF001FFF),
                        height: 1
                    ),
                  ),
                  SizedBox(height: h * 0.02,),

                  Text(AppStrings.REFERAL_MESSAGE,
                    style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        color: Color(0xFF606060),
                      height: 1.2
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: h * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: h * 0.045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/envelope.svg'),
                              SizedBox(width: w * 0.02,),
                              Text('Email',
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
                      SizedBox(width: w * 0.02,),

                      Container(
                        height: h * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [Color(0xFF41BC60), Color(0xFF1E562C)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/whatsapp_logo.svg'),
                              SizedBox(width: w * 0.02,),
                              Text('Whatsapp',
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
                      )
                    ],
                  ),
                  SizedBox(height: h * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferralStatus()));
                        },
                        child: Container(
                          height: h * 0.045,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF1F1F1)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                            child: Row(
                              children: [
                                Text('Check referral status',
                                  style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: w * 0.02,),
                                SvgPicture.asset('assets/icons/arrow_black_right.svg'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.025,),
                  Text('SHARE YOUR LINK',
                    style: TextStyle(
                      fontSize: fontSizes.fontSize12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins_semi_bold',
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: h * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              SvgPicture.asset('assets/icons/export_link.svg'),
                              SizedBox(width: w * 0.02,),
                              Text('https://lmrf/8DLLiaCbKs7sodf',
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
                  SizedBox(height: h * 0.03,),
                  Text('Questions?',
                    style: TextStyle(
                      fontSize: fontSizes.fontSize14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.006,),
                  RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'See our ',
                            style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontWeight: FontWeight.w500,
                              fontSize: fontSizes.fontSize12,
                              color: Colors.black
                            )
                          ),
                          TextSpan(
                              text: 'Referral FAQ',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Colors.black
                              )
                          ),
                          TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize12,
                                  color: Colors.black
                              )
                          ),
                          TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Colors.black
                              )
                          )
                        ]
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
