import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/BookParty/partySelectFood.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';

import '../Constants/appFontSizes.dart';

class PartySelectPackage extends StatefulWidget {
  const PartySelectPackage({super.key});

  @override
  State<PartySelectPackage> createState() => _PartySelectPackageState();
}

class _PartySelectPackageState extends State<PartySelectPackage>{
  late double w, h;
  bool isSelected = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Check the scroll direction
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // Scrolling down - hide the container
        /*if (isSelected) {
          setState(() {
            isSelected = false;
          });
        }*/
        print('Scrolling Down');
        setState(() {
          isSelected = false;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        // Scrolling up - show the container
        /*if (!isSelected) {
          setState(() {
            isSelected = true;
          });
        }*/
        print('Scrolling UP');
        setState(() {
          isSelected = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Packages",
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
                          "(2/6)",
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
                    color: Color(0xFFDCDCDC),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFFDCDCDC),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFFDCDCDC),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFFDCDCDC),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFFDCDCDC),
                  ),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFFDCDCDC),
                  ),
                  Container(
                    height: h * 0.002,
                    width: w * 0.15,
                    color: Color(0xFFDCDCDC),
                  ),
                ],
              ),
              
              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                child: Text('Packages for 56 Peoples',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSizes.fontSize24,
                    fontFamily: 'Supreme_bold',
                    color: Colors.black
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 7,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          _buildItems(),
                          SizedBox(height: h * 0.02,)
                        ],
                      );
                    }
                ),
              ),
              // SizedBox(height: h * 0.15,)
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
                    padding: EdgeInsets.only(right: w * 0.04, bottom: h * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset('assets/icons/view_booking.svg'),
                                SizedBox(width: w * 0.02,),
                                Text('View Bookings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins_semi_bold',
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.01,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectFood()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF001FFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('assets/icons/party_booking_cart.svg'),
                                  SizedBox(width: w * 0.02,),
                                  Text('Continue Booking',
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
                                      color: Colors.black.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.005, bottom: h * 0.005),
                                      child: Text('₹4000',
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
  Widget _buildItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset('assets/images/party_hall.png',
            height: h * 0.155,
            width: w * 0.35,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: w * 0.03,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shrikant Hall',
                style: TextStyle(
                    fontFamily: 'Poppins_semi_bold',
                    fontSize: fontSizes.fontSize16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: w * 0.02,),
                  Text('Minimum 30 people',
                    style: TextStyle(
                        fontFamily: 'Poppins_regular',
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: w * 0.02,),
                  Expanded(
                    child: Text('Food, Decor, Lighting, and amenities included.',
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: h * 0.01,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected = true;
                      });

                      // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectHall()));
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.2,
                      decoration: BoxDecoration(
                        // color: Color(0xFF001FFF),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFCE00DC),
                              Color(0xFF011EF4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          'Book',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizes.fontSize16,
                              color: Colors.white
                            // fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.03,),
                  Text('₹400 /hour',
                    style: TextStyle(
                        fontFamily: 'Poppins_regular',
                        fontSize: fontSizes.fontSize12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
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
