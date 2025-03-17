import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';

import '../Constants/animatedRoute.dart';

class AllPartyBooking extends StatefulWidget {
  const AllPartyBooking({super.key});

  @override
  State<StatefulWidget> createState() => _AllPartyBookinngState();
}

class _AllPartyBookinngState extends State<AllPartyBooking>{
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
                            "All Bookings",
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
              Expanded(
                child: ListView.builder(
                    // controller: _scrollController,
                    itemCount: 3,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: h * 0.02),
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartyBookingHallDetails()));
                        },
                        child: Column(
                          children: [
                            _buildItems(),
                            SizedBox(height: h * 0.02,)
                          ],
                        ),
                      );
                    }
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Banquet Hall',
                          style: TextStyle(
                            fontFamily: 'Poppins_semi_bold',
                            fontSize: fontSizes.fontSize16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        Container(
                          height: h * 0.005,
                          width: w * 0.012,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black
                            /*gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFCE00DC), // Start color
                                Color(0xFF011EF4),
                              ],
                            ),*/
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        Text('Package 1',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEEF0FF),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.005, bottom: h * 0.005),
                        child: Text('Successful',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize14,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF001FFF)

                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text('#347983272',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSizes.fontSize14,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black

                  ),
                ),
                Text('21/11/2024 (13:30-20:30)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: fontSizes.fontSize14,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black

                  ),
                ),
                SizedBox(height: h * 0.01,),
                Row(
                  children: [
                    Container(
                      // height: h * 0.05,
                      // width: w * 0.2,
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
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                          child: Text(
                            'Book Again',
                            style: TextStyle(
                                fontFamily: 'Poppins_semi_bold',
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize12,
                                color: Colors.white
                              // fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: w * 0.02,),
                    Container(
                      // height: h * 0.05,
                      // width: w * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.transparent,

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                          child: Text(
                            'View Invoice',
                            style: TextStyle(
                                fontFamily: 'Poppins_semi_bold',
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizes.fontSize12,
                                color: Colors.black
                              // fontSize: 14
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.02,),
          Container(
            height: h * 0.001,
            width: w,
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

