import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/BookParty/bookPartyLanndingScreen.dart';
import 'package:living_menu_mobile/ComingSoon/comingSoon.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/DineIn/tableScanner.dart';

import '../Constants/GradientText.dart';
import '../Constants/appFontSizes.dart';
import '../Profile/profile.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore>{
  late double w, h;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.05, left: w * 0.03, right: w * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('Explore',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Supreme_bold',
                          fontSize: fontSizes.fontSize24,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/notification_icon.svg',
                        width: w * 0.08,
                      ),
                      SizedBox(width: w * 0.025,),
                      SvgPicture.asset(
                        'assets/icons/cart_bag_icon.svg',
                        width: w * 0.06,
                      ),
                      SizedBox(width: w * 0.03,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Profile()));
                        },
                        child: Container(
                          height: h * 0.029,
                          width: w * 0.062,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF001FFF), Color(0xFF001FFF)], // Set your gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25), // Adjust the border radius
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25), // Ensure the same radius is applied to the image
                                  child: Image.asset(
                                    'assets/images/profile_img.png',
                                    height: h * 0.027,
                                    width: w * 0.058,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.02, left: w * 0.03, right: w * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset('assets/images/book_parties.png',),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Book Parties',
                                  style: TextStyle(
                                    fontFamily: 'Poppins_bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize16,
                                    color: Colors.white
                                  ),
                                ),
                                Container(
                                  width: w * 0.55,
                                  child: Text('Reserve rooms for birthday, anniversary, and private events.',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.015,),
                                Row(
                                  children: [
                                    Text('12 hour billings',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.white
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                                      child: Container(
                                        height: h * 0.005,
                                        width: w * 0.012,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                          borderRadius: BorderRadius.circular(25)
                                        ),
                                      ),
                                    ),
                                    Text('Meal options',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.035,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(BookPartyLandingScreen()));
                                  },
                                  child: Container(
                                    height: h * 0.06,
                                    width: w * 0.22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Book',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize16,
                                            color: Colors.black
                                          ),
                                        ),
                                        SizedBox(width: w * 0.02,),
                                        SvgPicture.asset('assets/icons/arrow_right_black.svg')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              
              
                      SizedBox(height: h * 0.01,),
                      Stack(
                        children: [
                          Image.asset('assets/images/book_dinein.png',),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dine In',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                  child: Container(
                                    width: w * 0.55,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.008),
                                          child: Container(
                                            height: h * 0.005,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.01,),
                                        Expanded(
                                          child: Text('Get your orders directly on the table.',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                  child: Container(
                                    width: w * 0.55,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.008),
                                          child: Container(
                                            height: h * 0.005,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.01,),
                                        Expanded(
                                          child: Text('Track orders live',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
              
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                  child: Container(
                                    width: w * 0.55,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.008),
                                          child: Container(
                                            height: h * 0.005,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.01,),
                                        Expanded(
                                          child: Text('Give special instructions',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
              
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                  child: Container(
                                    width: w * 0.55,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.008),
                                          child: Container(
                                            height: h * 0.005,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.01,),
                                        Expanded(
                                          child: Text('Pay online',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
              
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                  child: Container(
                                    width: w * 0.55,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.008),
                                          child: Container(
                                            height: h * 0.005,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.01,),
                                        Expanded(
                                          child: Text('Avail special discounts',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
              
                                SizedBox(height: h * 0.04,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(TableScanner()));
                                  },
                                  child: Container(
                                    height: h * 0.06,
                                    width: w * 0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('assets/icons/qr_code.svg'),
                                        SizedBox(width: w * 0.02,),
                                        Text('Scan Table QR',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize16,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              
                      SizedBox(height: h * 0.01,),
                      Container(
                        width: w,
                        height: h * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF001FFF), // Start color
                              Color(0xFF001399),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/icons/Prime_enable.png',
                                        width: w * 0.05,
                                      ),
                                      SizedBox(width: w * 0.015,),
                                      GradientText(
                                        "Living Menu Prime",
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
                                    ],
                                  ),
                                  SizedBox(height: h * 0.01,),

                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.008),
                                            child: Container(
                                              height: h * 0.005,
                                              width: w * 0.012,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Expanded(
                                            child: Text('Gift cards & cash backs on every order',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize12,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.008),
                                            child: Container(
                                              height: h * 0.005,
                                              width: w * 0.012,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Expanded(
                                            child: Text('TWin rewards by playing easy games',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize12,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.015, top: h * 0.002),
                                    child: Container(
                                      width: w * 0.82,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.008),
                                            child: Container(
                                              height: h * 0.005,
                                              width: w * 0.012,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(25)
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Expanded(
                                            child: Text('Never miss on special offers and limited coupon codes',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize12,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                  Container(
                                    height: h * 0.1,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 0,
                                            left: -(w * 0.015),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: w * 0.02),
                                                  child: Container(
                                                    width: w * 0.85,
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
                                            left: -(w * 0.025),
                                            child: Image.asset(
                                              'assets/images/reward_save.png',
                                              width: w * 0.3,
                                            )
                                        ),
                                        Positioned(
                                            bottom: h * 0.01,
                                            // bottom: -(h * 0.03),
                                            left: w * 0.21,
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







                                ],
                              ),
                            ),

                            SizedBox(height:  h * 0.015,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Delivery benefits',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                                  child: Container(
                                    height: h * 0.005,
                                    width: w * 0.012,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                  ),
                                ),
                                Text('Rewards',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.white
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.01, right: w * 0.01),
                                  child: Container(
                                    height: h * 0.005,
                                    width: w * 0.012,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                  ),
                                ),
                                Text('Discounts',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),





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
                                          _buildTextWithLine(),
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
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ComingSoon()));
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
                                        Text('Coming Soon',
                                          style: TextStyle(
                                            fontSize: fontSizes.fontSize16,
                                            fontFamily: 'Poppins_bold',
                                            color: Color(0xFF001FFF),
                                            height: 1,
                                          ),
                                        ),
                                        /*GradientText(
                                          // "Get Prime Now",
                                          "Coming Soon",
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
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
              
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextWithLine() {
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
            '₹499',
            style: TextStyle(
              fontSize: fontSizes.fontSize10,
              color: Color(0xFF939393),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

}
