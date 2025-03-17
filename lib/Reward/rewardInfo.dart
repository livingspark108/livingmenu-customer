import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/GradientText.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Reward/rewards.dart';

import '../Constants/appFontSizes.dart';

class  RewardInfo extends StatefulWidget {
  const RewardInfo ({Key? key}) : super(key: key);

  @override
  State<RewardInfo> createState() => RewardInfoState();
}

class RewardInfoState extends State<RewardInfo> {
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
                  Color(0xFF001FFF), // Start color
                  Color(0xFF001399),
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
                            top: h * 0.175,
                            left: w * 0.25,
                            child: Container(
                              width: w * 0.55,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/icons/Prime_enable.png',
                                          width: w * 0.05,
                                          height: h * 0.025,
                                        ),
                                        SizedBox(width: w * 0.015,),
                                        GradientText(
                                          "Prime",
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF8E0A5),
                                              Color(0xFFEBA856),
                                            ],
                                          ),
                                          // fontSize: 10,
                                          fontSize: fontSizes.fontSize24,
                                          fontFamily: 'Archivo_bold',
                                          height: 1,
                                        ),
                                        SizedBox(width: w * 0.015,),
                                        Image.asset('assets/icons/reward_gift_icon.png',
                                          width: w * 0.07,
                                          height: h * 0.035,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GradientText(
                                    "Rewards",
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF8E0A5),
                                        Color(0xFFEBA856),
                                      ],
                                    ),
                                    fontSize: fontSizes.fontSize40,
                                    fontFamily: 'Archivo_bold',
                                    height: 0.85,
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Text('Premium Membership Plan Delicious Rewards, Again & Again',
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
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icons/reward_gift_redeem.png',
                                        height: h * 0.02,
                                        width: w * 0.04,
                                      ),
                                      SizedBox(width: w * 0.03,),
                                      Text('Gift cards and Cash backs on every order',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
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
                                    children: [
                                      Image.asset('assets/icons/reward_game.png',
                                        height: h * 0.02,
                                        width: w * 0.04,
                                      ),
                                      SizedBox(width: w * 0.03,),
                                      Text('Win rewards by playing easy games',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
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
                                      Image.asset('assets/icons/reward_badge.png',
                                        height: h * 0.02,
                                        width: w * 0.04,
                                      ),
                                      SizedBox(width: w * 0.03,),
                                      Expanded(
                                        child: Text('Never miss on special offers and limited coupon codes',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                              color: Colors.white
                                          ),
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
                                'assets/images/reward_save.png',
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
                                  GradientText(
                                    "Save over ₹100 in 1 month",
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF8E0A5),
                                        Color(0xFFEBA856),
                                      ],
                                    ),
                                    // fontSize: 10,
                                    fontSize: fontSizes.fontSize14,
                                    // fontSize: fontSizes.fontSize36,
                                    fontFamily: 'Poppins_regular',
                                    height: 1,
                                  ),
                                  Text('with just 2 orders',
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
                      padding: EdgeInsets.only(bottom: h * 0.2, left: w * 0.05, right: w * 0.05),
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
                // height: h * 0.18,
                width: w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF001FFF), // Start color
                      Color(0xFF001399),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                      child: Container(
                        // height: h * 0.07,
                        width: w,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFFEBA856),
                            width: w * 0.001
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.013),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('For 1 month',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.white
                                    ),
                                  ),
                                  GradientText(
                                    "Most Popular",
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFEBA856),
                                        Color(0xFFF8E0A5),
                                      ],
                                    ),
                                    // fontSize: 10,
                                    fontSize: fontSizes.fontSize12,
                                    fontFamily: 'Poppins_regular',
                                    height: 1,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _buildTextWithLine('₹499'),
                                  Text('₹29',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, bottom: h * 0.02, top: h * 0.015),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Rewards()));
                        },
                        child: Container(
                          // height: h * 0.05,
                          width: w,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF8E0A5), // Start color
                              Color(0xFFEBA856),
                            ],
                          ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientText(
                                  "Get Prime Now",
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF001FFF),
                                      Color(0xFF001399),
                                    ],
                                  ),
                                  // fontSize: 10,
                                  fontSize: fontSizes.fontSize16,
                                  fontFamily: 'Poppins_bold',
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  child: Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget _buildTextWithLine(String text) {
    AppFontSizes fontSizes = AppFontSizes(context);
    return Stack(
      alignment: Alignment.center, // Aligns children at the center
      children: [
        // This is the line
        Container(
          width: w * 0.05,  // Line width, adjust as needed
          height: h * 0.001,   // Line thickness
          color: Color(0xFF939393), // Line color
        ),
        // This is the text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding if needed
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSizes.fontSize10,
              color: Color(0xFF939393),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }*/

  Widget _buildTextWithLine(String text) {
    AppFontSizes fontSizes = AppFontSizes(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the width of the text by using the TextPainter
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSizes.fontSize14,
              fontFamily: 'Poppins_semi_bold',
              color: Color(0xFF939393),
              fontWeight: FontWeight.w500,
            ),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        // Get the width of the text
        double textWidth = textPainter.width;

        return Stack(
          alignment: Alignment.center, // Align children at the center
          children: [
            // This is the line, adjusted according to the text width
            Container(
              width: textWidth + w * 0.01,  // Line width slightly larger than the text width
              height: h * 0.001,  // Line thickness
              color: Color(0xFF939393), // Line color
            ),
            // This is the text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding if needed
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSizes.fontSize14,
                  fontFamily: 'Poppins_semi_bold',
                  color: Color(0xFF939393),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
