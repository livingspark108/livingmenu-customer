import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/ComingSoon/comingSoon.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/DineIn/tableScanner.dart';

import '../Constants/appFontSizes.dart';

class  DineIn extends StatefulWidget {
  const DineIn ({Key? key}) : super(key: key);

  @override
  State<DineIn> createState() => _DineInState();
}

class _DineInState extends State<DineIn> {
  late double w, h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFDC8800), // Start color
                  Color(0xFFF45601),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: h * 0.65,
                      child: Stack(
                        children: [
                          Image.asset('assets/images/dinein_round_bg.png',),
                          Positioned(
                            top: h * 0.15,
                            left: w * 0.28,
                            child: Container(
                              width: w * 0.45,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Dine In',
                                    style: TextStyle(
                                      fontFamily: 'Archivo_bold',
                                      fontWeight: FontWeight.w400,
                                      fontSize: fontSizes.fontSize40,
                                      color: Colors.white
                                      // fontSize: fontSizes.fontSize36
                                    ),
                                  ),
                                  Text('Get special discounts, and vouchers with our app',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            // bottom: 500,
                            // top: 100,
                            top: h * 0.35, // Adjust to position just below the main text
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                                  child: Text('1. Scan QR on the Table',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02, bottom: h * 0.02),
                                  child: Container(
                                    width: w,
                                    height: h * 0.0003,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                                  child: Text('2. Choose from the extensive menu',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02, bottom: h * 0.02),
                                  child: Container(
                                    width: w,
                                    height: h * 0.0003,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('3. ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.white
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('Track live and also give special instructions like less spicy, no onion - no garlic, etc.',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                              color: Colors.white
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.05),
                                    child: Container(
                                      width: w * 0.9,
                                      height: h * 0.06,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          Positioned(
                              // bottom: -25,
                              bottom: -(h * 0.03),
                              left: w * 0.025,
                              child: Image.asset(
                                'assets/images/dinein_save.png',
                                width: w * 0.3,
                              )
                          ),
                          Positioned(
                            bottom: h * 0.01,
                            // bottom: -(h * 0.03),
                              left: w * 0.26,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Save over ₹100 on app wallet',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.white
                                    ),
                                  ),
                                  Text('with minimum order of ₹800',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                          ),


                        ],

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, top: h * 0.02),
                      child: Text('FAQs',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Supreme_bold',
                            color: Colors.white
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h * 0.02),
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: 7,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index){
                            return Column(
                              children: [
                                _buildItem(index),
                                SizedBox(height: h * 0.01,)
                              ],
                            );
                          }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: h * 0.13, left: w * 0.05, right: w * 0.05),
                      child: Container(
                        height: h * 0.055,
                        width: w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Terms & Conditions',
                              style: TextStyle(
                                  fontSize: fontSizes.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(width: w * 0.04,),
                            SvgPicture.asset('assets/icons/arrow_right_white.svg',
                              color: Color(0xFFF8E0A5),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: h * 0.1,
                width: w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFDC8800), // Start color
                      Color(0xFFF45601),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.025, top: h * 0.025),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(TableScanner()));
                      // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ComingSoon()));
                    },
                    child: Container(
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/qr_code.svg'),
                          SizedBox(width: w * 0.015,),
                          Text('Scan Table QR',
                            style: TextStyle(
                                fontSize: fontSizes.fontSize16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_semi_bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  List<bool> _isExpandedList = List.filled(7, false);

  Widget _buildItem(int index){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Padding(
      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
      child: Container(
        width: w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isExpandedList[index] ? Color(0xFFF8E0A5) : Colors.transparent,
            width: w * 0.001

          )
        ),
        child: InkWell(
          onTap: (){
            setState(() {
              _isExpandedList[index] = !_isExpandedList[index];
            });

          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.03, top: h * 0.015, bottom: h * 0.015),
                    child: Text('What is Living Menu Prime?',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        color: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.04),
                    child: SvgPicture.asset(
                      _isExpandedList[index]
                        ? 'assets/icons/arrow_up_orange.svg'
                          : 'assets/icons/arrow_down_orange.svg',
                      color: Color(0xFFF8E0A5),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _isExpandedList[index],
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.1, top: h * 0.001, bottom: h * 0.015),
                  //Removed Expanded Widget from here due to gray box issue
                  child: Text('Living Menu Prime is a membership program which aims to make your experience with Living Menu more rewarding by providing exclusive benefits whenever you order your food.',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins_regular',
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
