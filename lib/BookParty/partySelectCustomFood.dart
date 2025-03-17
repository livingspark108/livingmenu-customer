import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/BookParty/partySelectDecoration.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class PartySelectCustomFood extends StatefulWidget {
  const PartySelectCustomFood({super.key});

  @override
  State<PartySelectCustomFood> createState() => _PartySelectFood();
}

class _PartySelectFood extends State<PartySelectCustomFood> {
  late double w, h;
  int addOnsFirstItemSelectedIndex = 0;

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
                          "Food",
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
                          "(3/6)",
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
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                          child: Text('Starter (Any one)',
                            style: TextStyle(
                                fontSize: fontSizes.fontSize16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins_semi_bold'
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                          // child: Container(
                          //   height: itemHeight * innerItemCount + 1, // Calculate total height
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: index == 3 ? 1 : 3,
                            itemBuilder: (BuildContext context, int rowIndex) {
                              /*return InkWell(
                                onTap: (){
                                  setState(() {
                                    // addOnsFirstItemSelectedIndex = rowIndex;
                                  });
                                },
                                child: _buildItems(),
                              );*/

                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    // addOnsFirstItemSelectedIndex = rowIndex;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                  child: _buildItems(addOnsFirstItemSelectedIndex, rowIndex, index),
                                  // child: _buildItems(rowIndex, index),
                                ),
                              );
                            },
                          ),
                          // ),
                        ),
                      ],
                    );
                  },
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
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectDecoration()));
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
                              padding: EdgeInsets.only(top: h * 0.015, bottom: h * 0.015),
                              child: Center(
                                child: Text('Choose Decoration',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Supreme_bold',
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              /*child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  // SvgPicture.asset('assets/icons/party_booking_cart.svg'),
                                  // SizedBox(width: w * 0.02,),
                                  Text('Choose Decoration',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Supreme_bold',
                                        fontSize: fontSizes.fontSize16,
                                        color: Colors.white
                                    ),
                                  ),
                                  *//*SizedBox(width: w * 0.02,),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: h * 0.005, bottom: h * 0.005),
                                      child: Text('₹4000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Supreme_bold',
                                            fontSize: fontSizes.fontSize16,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  )*//*
                                ],
                              ),*/
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

  // Widget _buildItems(int selectedIndex, int rowIndex, int index){
  Widget _buildItems(int selectedIndex, int rowIndex, int index){
    bool isSelected = rowIndex == selectedIndex;
    // bool isAddClicked = _addOnClickedStatus[rowIndex] ?? false;
    if (index == 0) {
      return _buildRadioItem(isSelected);
    }else {
      return _buildCheckBoxItems();
    }
  }

  Widget _buildCheckBoxItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: h * 0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/burger.png',
                      height: h * 0.04,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text('Oregano (x2)',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  /* Text('₹20.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_regular',
                        color: Colors.black
                    ),
                  ),*/
                  SizedBox(width: w * 0.025,),
                  SvgPicture.asset('assets/icons/check_black_selected.svg'),
                ],
              )
              /*SvgPicture.asset(
                  isSelected
                      ? 'assets/icons/circle_selected.svg'
                      : 'assets/icons/circle_unselected.svg'
              )*/
            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          )
        ],
      ),
    );
  }

  Widget _buildRadioItem(bool isSelected){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: h * 0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/burger.png',
                      height: h * 0.04,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text('Oregano (x2)',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  /* Text('₹20.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_regular',
                        color: Colors.black
                    ),
                  ),*/
                  SizedBox(width: w * 0.025,),
                  SvgPicture.asset('assets/icons/radio_select_small.svg'),
                ],
              )
              /*SvgPicture.asset(
                  isSelected
                      ? 'assets/icons/circle_selected.svg'
                      : 'assets/icons/circle_unselected.svg'
              )*/
            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          )
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

