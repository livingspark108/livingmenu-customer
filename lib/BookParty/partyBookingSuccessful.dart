import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class PartyBookingSuccessful extends StatefulWidget {
  const PartyBookingSuccessful({super.key});

  @override
  State<PartyBookingSuccessful> createState() => _PartyBookingSuccessful();
}

class _PartyBookingSuccessful extends State<PartyBookingSuccessful>{
  late double w, h;
  bool _isReceiptOpen = false;
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
          Image.asset('assets/images/purchase_successful_bg.png',
            width: w,
            height: h,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Container(
                height: h * 0.16,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.06, left: w * 0.04, right: w * 0.04),
                      child: Container(

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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.04,),
              Column(
                children: [
                  SvgPicture.asset('assets/icons/booking_successful.svg'),
                  SizedBox(height: h * 0.005,),
                  Text('Booking Successful',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: fontSizes.fontSize24,
                      fontFamily: 'Supreme_bold',
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: h * 0.005,),
                  Text('#347983273 - Banquet Hall (Package 2)',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizes.fontSize14,
                        fontFamily: 'Poppins_regular',
                        color: Colors.white
                    ),
                  ),
                  Text('21/11/2024 (13:30-20:30)',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizes.fontSize14,
                        fontFamily: 'Poppins_regular',
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: h * 0.015,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/share.svg'),
                      SizedBox(width: w * 0.03,),
                      SvgPicture.asset('assets/icons/download.svg'),
                    ],
                  ),

                  SizedBox(height: h * 0.02,),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 20,
                          spreadRadius: 10,
                          color:
                          Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                          child: Image.asset('assets/images/party_booking_bg.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Billed To',
                                    style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontSize: fontSizes.fontSize16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                    ),
                                  ),
                                  Text('Paid: ₹2000',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF001FFF)
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: h * 0.005,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Mahendra Shastri',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('Due: ₹2000',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFB3261E)
                                    ),
                                  ),
                                ],
                              ),
                              Text('+91 9746352759',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  height: 1
                                ),
                              ),
                              SizedBox(height: h * 0.03,),
                              Text('Billed To',
                                style: TextStyle(
                                    fontFamily: 'Poppins_semi_bold',
                                    fontSize: fontSizes.fontSize16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Banquet Hall',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                  Text('₹2000',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Food',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                  Text('₹800',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Decoration',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                  Text('₹1000',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Others',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                  Text('₹200',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semi_bold',
                                        fontSize: fontSizes.fontSize16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        height: 1.2
                                    ),
                                  ),
                                  Text('₹4000',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_semi_bold',
                                        fontSize: fontSizes.fontSize16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF001FFF),
                                        height: 1.2
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.04,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _isReceiptOpen = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset('assets/icons/receipt_white_small.svg'),
                                          SizedBox(width: w * 0.02,),
                                          Text('View Item Receipt',
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
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
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
                            // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartyBookingSuccessful()));
                          },
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFD8D8),
                              /*gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFCE00DC),
                                  Color(0xFF011EF4),
                                ],
                              ),*/
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
                                  Text('Pay Balance',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Supreme_bold',
                                        fontSize: fontSizes.fontSize16,
                                        color: Colors.black
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
                                            color: Colors.black
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
          Positioned(
            bottom: 0,
              right: w * 0.04,
              left: w * 0.04,
              child: Visibility(
                visible: _isReceiptOpen,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  width: w,
                  constraints: BoxConstraints(
                    maxHeight: h * 0.8
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 20,
                        spreadRadius: 10,
                        color:
                        Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  _isReceiptOpen = false;
                                });
                              },
                                child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                            ),
                            SizedBox(width: w * 0.03,),
                            Text('Selected Items',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize24,
                                fontFamily: 'Supreme_bold',
                                color: Colors.black
                              ),
                            ),
                          ],
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: h * 0.02,),
                                Text('Food',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.black
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Starter',
                                          style: TextStyle(
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular'
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.005, bottom: h * 0.005),
                                          // child: Container(
                                          //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (BuildContext context, int rowIndex) {
                                              return _buildSubItems();
                                            },
                                          ),
                                          // ),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                SizedBox(height: h * 0.03,),

                                Text('Decoration',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.black
                                  ),
                                ),

                                ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Lighting',
                                          style: TextStyle(
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular'
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.005, bottom: h * 0.005),
                                          // child: Container(
                                          //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (BuildContext context, int rowIndex) {
                                              return _buildSubItems();
                                            },
                                          ),
                                          // ),
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                SizedBox(height: h * 0.03,),

                                Text('Others',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.black
                                  ),
                                ),

                                ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Props',
                                          style: TextStyle(
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular'
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.005, bottom: h * 0.005),
                                          // child: Container(
                                          //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (BuildContext context, int rowIndex) {
                                              return _buildSubItems();
                                            },
                                          ),
                                          // ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: h * 0.1,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildSubItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox( width: w * 0.02,),
            CircleAvatar(
              radius: 2,
              backgroundColor: Colors.black,
            ),
            SizedBox( width: w * 0.02,),
            Text('Water Bottle',
              style: TextStyle(
                fontFamily: 'Poppins_regular',
                fontSize: fontSizes.fontSize12,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
            ),
          ],
        ),
        Text('₹80.00',
          style: TextStyle(
              fontFamily: 'Poppins_regular',
              fontSize: fontSizes.fontSize12,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
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
