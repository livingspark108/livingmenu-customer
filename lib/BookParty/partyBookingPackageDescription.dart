import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/BookParty/partySelectCustomFood.dart';
import 'package:living_menu_mobile/BookParty/partySelectFood.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class PartyBookingPackageDescription extends StatefulWidget {
  const PartyBookingPackageDescription({super.key});

  @override
  State<PartyBookingPackageDescription> createState() => _PartyBookingPackageDescriptionState();
}

class _PartyBookingPackageDescriptionState extends State<PartyBookingPackageDescription>{
  late double w, h;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
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
                    SizedBox(height: h * 0.015,),
                  ],
                ),
              ),
              Stack(
                children: [
                  Image.asset('assets/images/party_hall.png',
                    height: h * 0.33,
                    width: w,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    height: h * 0.33,
                    width: w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0), // Start color
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: h * 0.025,
                    left: w * 0.02,
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Banquet Hall',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Quicksand_light',
                                color: Color(0xFFEAEAEA)
                            ),
                          ),
                          Text('Package 1',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize24,
                                fontFamily: 'Quicksand_bold',
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02,),
                    Text('₹300 /Person',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: fontSizes.fontSize16,
                          fontFamily: 'Poppins_bold',
                          color: Colors.black
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.03, top: h * 0.005),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: h * 0.006,
                                width: w * 0.012,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Text('Meals',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: h * 0.006,
                                width: w * 0.012,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Text('Refreshments',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: h * 0.006,
                                width: w * 0.012,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Text('etc.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          /*Row(
                            children: [
                              Container(
                                height: h * 0.006,
                                width: w * 0.012,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Text('Max People: 22',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: h * 0.006,
                                width: w * 0.012,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Text('Amenities',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: h * 0.17,
                width: w,
                color: Colors.white,
                child: Column(
                  children: [
                    /* Container(
                      height: h * 0.001,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),*/
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.022),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectFood()));
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
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
                              'Quick Booking',
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
                    ),


                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectCustomFood()));
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF001FFF),
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              'Customise Party',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Color(0xFF001FFF)
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
    );
  }

  Widget _buildItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Row(
      children: [
        Container(
          height: h * 0.006,
          width: w * 0.012,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black
          ),
        ),
        SizedBox(width: w * 0.02,),
        Text('Chairs',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontSizes.fontSize14,
              fontFamily: 'Poppins_regular',
              color: Colors.black
          ),
        ),
      ],
    );
  }

}
