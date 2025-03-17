import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/BookParty/partyBookingSuccessful.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class PartyCheckout extends StatefulWidget {
  const PartyCheckout({super.key});

  @override
  State<PartyCheckout> createState() => _PartyCheckout();
}

class _PartyCheckout extends State<PartyCheckout> {
  late double w, h;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.06, left: w * 0.04, right: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                'assets/icons/header_back.svg',
                                width: w * 0.04,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                // _showAddressPopup(context);
                              },
                              child: Container(
                                child: Row(
                                  children: [

                                    SizedBox(width: w * 0.03,),
                                    Text('Jaipur',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                      ),
                                    ),
                                    SizedBox(width: w * 0.015,),
                                    SvgPicture.asset(
                                      'assets/icons/down_arrow_black.svg',
                                      width: w * 0.04,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Notifications()));
                              },
                              child: SvgPicture.asset(
                                'assets/icons/notification_icon.svg',
                                width: w * 0.08,
                              ),
                            ),
                            SizedBox(width: w * 0.025,),
                            GestureDetector(
                              onTap: (){
                                // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                              },
                              child: SvgPicture.asset(
                                'assets/icons/cart_bag_icon.svg',
                                width: w * 0.06,
                              ),
                            ),
                            SizedBox(width: w * 0.03,),
                            GestureDetector(
                              onTap: (){
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => const Profile()));
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
                    SizedBox(height: h * 0.02,),
                    Row(
                      children: [
                        GradientText(
                          "Checkout",
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCE00DC),
                              Color(0xFF011EF4),
                            ],
                          ),
                          // fontSize: 60,
                          fontSize: fontSizes.fontSize24,
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        SizedBox(width: w * 0.02,),
                        Container(
                          height: h * 0.01,
                          width: w * 0.02,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFCE00DC), // Start color
                                Color(0xFF011EF4),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        GradientText(
                          "Jaipur",
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCE00DC),
                              Color(0xFF011EF4),
                            ],
                          ),
                          // fontSize: 60,
                          fontSize: fontSizes.fontSize24,
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        SizedBox(width: w * 0.02,),
                        GradientText(
                          "(6/6)",
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCE00DC),
                              Color(0xFF011EF4),
                            ],
                          ),
                          // fontSize: 60,
                          fontSize: fontSizes.fontSize12,
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02,),
              Row(
                children: [
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF001FFF),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF001FFF),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF001FFF),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF001FFF),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF001FFF),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFF001FFF),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Please Pay 50% Advance for Booking',
                      style: TextStyle(
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: h * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booking Amount',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        Text('₹2000',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due on Arrival',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFB3261E)
                          ),
                        ),
                        Text('₹2000',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFB3261E)

                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: h * 0.005,),
              Container(
                width: w,
                height: h * 0.028,
                color: Color(0xFFEEF0FF),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                        style: TextStyle(
                            fontFamily: 'Poppins_semi_bold',
                            fontSize: fontSizes.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                      Text('₹4000',
                        style: TextStyle(
                            fontFamily: 'Poppins_semi_bold',
                            fontSize: fontSizes.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF001FFF)

                        ),
                      ),
                    ],
                  )
                ),
              ),
              SizedBox(height: h * 0.02,),
              Container(
                height: h * 0.008,
                width: w,
                color: Color(0xFFF1F1F1),
              ),

              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Party Details',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        SvgPicture.asset('assets/icons/down_arrow_black.svg')
                      ],
                    ),
                    SizedBox(height: h * 0.01,),
                    Text('21/11/2024 (13:30-20:30)',
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF606060)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01,),
              Container(
                height: h * 0.008,
                width: w,
                color: Color(0xFFF1F1F1),
              ),
              SizedBox(height: h * 0.02,),

              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Overview',
                      style: TextStyle(
                          fontFamily: 'Poppins_semi_bold',
                          fontSize: fontSizes.fontSize16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: h * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Banquet Hall',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        Text('₹4000',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Food',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        Text('₹800',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Decoration',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        Text('₹1000',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black

                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.005,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Others',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        Text('₹200',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black

                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: h * 0.01,),
              Container(
                width: w,
                height: h * 0.028,
                color: Color(0xFFEEF0FF),
                child: Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        Text('₹4000',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF001FFF)

                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),


          Positioned(
              bottom: 0,
              right: 0,
              child: Visibility(
                visible: true,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  width: w,
                  child: Padding(
                    padding: EdgeInsets.only(right: w * 0.04, bottom: h * 0.02, left: w * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartyBookingSuccessful()));
                          },
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFCE00DC),
                                  Color(0xFF011EF4),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SvgPicture.asset('assets/icons/party_booking_cart.svg'),
                                  // SizedBox(width: w * 0.02,),
                                  Text('Pay Booking Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Supreme_bold',
                                        fontSize: fontSizes.fontSize16,
                                        color: Colors.white
                                    ),
                                  ),
                                  SizedBox(width: w * 0.02,),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: h * 0.005, bottom: h * 0.005),
                                      child: Text('₹2000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Supreme_bold',
                                            fontSize: fontSizes.fontSize16,
                                            color: Colors.white
                                        ),
                                      ),
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
                ),
              )
          ),

        ],
      ),
    );
  }

}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final double fontSize;
  final String fontFamily;
  final double height;
  final FontWeight fontWeight;

  GradientText(this.text, {required this.gradient, required this.fontSize,
    required this.fontFamily, required this.height, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            height: height
        ),
      ),
    );
  }
}

