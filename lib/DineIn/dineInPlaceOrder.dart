import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:living_menu_mobile/DineIn/dineInTrackOrder.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class DineInPlaceOrder extends StatefulWidget {
  DineInPlaceOrder({Key? key, required this.latLong}) : super(key: key);
  LatLng latLong;

  @override
  State<DineInPlaceOrder> createState() => _DineInPlaceOrderState();
}

class _DineInPlaceOrderState extends State<DineInPlaceOrder>{
  late double w,h;
  bool _isPreferenceOpen = false;
  bool isNongToggle = false;
  bool isLessOilToggle = false;
  String selectedSpiceLevel = 'Low';
  String selectedPreference = 'Once';
  bool isUseWallet = true;
  late LatLng _userLatLong;
  late String lat;
  late String long;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLatLong = widget.latLong;
    lat = _userLatLong.latitude.toString();
    long = _userLatLong.longitude.toString();
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
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: SvgPicture.asset('assets/icons/header_back.svg'),
                          ),
                        ),
                        // SizedBox(width: w * 0.29,),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Continue Shopping',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Color(0xFF606060)
                                  ),
                                ),
                                Text('Govindas Restaurant',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize14,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  /*Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),*/
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                    },
                    child: Container(
                      width: w,
                      height: h * 0.038,
                      color: Color(0xFFFFF7D3),

                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Scheduled Delivery',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12
                                  ),
                                ),
                                SizedBox(width: w * 0.01,),
                                Container(
                                  height: h * 0.004,
                                  width: w * 0.008,
                                  color: Colors.black,
                                ),
                                SizedBox(width: w * 0.01,),
                                Text('Tomorrow, 2:40 PM',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12
                                  ),
                                ),
                              ],
                            ),
                            SvgPicture.asset('assets/icons/right_arrow.svg',)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/watch.svg'),
                        SizedBox(width: w * 0.04,),
                        Expanded(
                          child: Text('19 min left to place your delivery order on living menu online order app. The orders will be closed at 10:30 pm.',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: fontSizes.fontSize10,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060)
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.01,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFE09B2D),
                  ),


                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Preferences',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize16,
                                fontFamily: 'Poppins_semi_bold'
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NONG',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Color(0xFF606060)
                                ),
                              ),
                              Text('Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize12,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Less Oily',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Color(0xFF606060)
                                ),
                              ),
                              Text('No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize12,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Spice Level',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Color(0xFF606060)
                                ),
                              ),
                              Text('Low',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize12,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.02,),
                          Text('Custom Preference',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize14,
                                fontFamily: 'Poppins_semi_bold',
                                color: Color(0xFF606060)
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Text('Don’t use cabbages & tomato sauce',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060)
                            ),
                          ),

                          SizedBox(height: h * 0.02,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isPreferenceOpen = true;
                                  });
                                  _ShowPreferenceItem(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                                    child: Text('Edit Preferences',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semi_bold',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
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
                  ),

                  SizedBox(height: h * 0.02,),
                  Container(
                    height: h * 0.01,
                    color: Color(0xFFF1F1F1),
                  ),
                  SizedBox(height: h * 0.02,),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/invoice.svg'),
                            SizedBox(width: w * 0.02,),
                            Text('View Invoice',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize14,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('₹198.56',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize14,
                                  color: Color(0xFF606060)
                              ),
                            ),
                            SizedBox(width: w * 0.02,),
                            SvgPicture.asset('assets/icons/arrow_right_black_big.svg'),


                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.03,),

                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Payment',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize14,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Razorpay',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize14,
                                  color: Color(0xFF606060)
                              ),
                            ),
                            SizedBox(width: w * 0.02,),
                            SvgPicture.asset('assets/icons/arrow_right_black_big.svg'),


                          ],
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
              child: Container(
                height: h * 0.15,
                width: w,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: h * 0.001,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(isUseWallet){
                                      isUseWallet = false;
                                    }else {
                                      isUseWallet = true;
                                    }
                                  });
                                },
                                child: Container(
                                    width: w * 0.05,
                                    child: SvgPicture.asset(
                                        isUseWallet ? 'assets/icons/checked_ractangle.svg' : 'assets/icons/unchecked_ractangle.svg'
                                    )
                                ),
                              ),
                              SizedBox(width: w * 0.04,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Use Living Menu Wallet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text('₹52.09',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF001FFF)
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.02, right: w * 0.04, left: w * 0.04),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DineInTrackOrder(latLong: _userLatLong)));
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                              color: Color(0xFF001FFF),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Place Order',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.white
                                  ),
                                ),
                                Text('₹198.56',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),


        ],
      ),
    );
  }








  void _ShowPreferenceItem(BuildContext context){
    AppFontSizes fontSizes = AppFontSizes(context);
    showModalBottomSheet(
      // isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return SingleChildScrollView(
                  child: Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.02,),

                        // I want to set below container before SingleChildScrollView
                        Container(
                          width: w * 0.35,
                          height: h * 0.005,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)
                            // color: Colors.black
                          ),
                        ),



                        SizedBox(height: h * 0.03,),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Preferences',
                                style: TextStyle(
                                    fontFamily: 'Poppins_semi_bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize16,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: h * 0.03,),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  setModalState((){
                                    if(isNongToggle){
                                      isNongToggle = false;
                                    }else {
                                      isNongToggle = true;
                                    }
                                  });

                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('NONG',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize14,
                                                color: Colors.black
                                            ),
                                          ),
                                          Text('No Onion No Garlic',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                        ],
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Switch(

                                          value: isNongToggle,
                                          onChanged: (bool value) {
                                            setModalState((){
                                              isNongToggle = value;
                                            });
                                            isNongToggle = value;
                                            print(isNongToggle);
                                          },
                                          activeTrackColor: Color(0xFF001FFF),
                                          inactiveTrackColor: Color(0xFFF2F4F7),
                                          inactiveThumbColor: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.03,),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  setModalState(() {
                                    if(isLessOilToggle){
                                      isLessOilToggle = false;
                                    }else {
                                      isLessOilToggle = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Less Oily',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize14,
                                                color: Colors.black
                                            ),
                                          ),
                                          Text('Try to minimise the use of oil',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                        ],
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Switch(

                                          value: isLessOilToggle,
                                          onChanged: (bool value) {
                                            setState(() {
                                              isLessOilToggle = value;
                                            });
                                            setModalState((){
                                              isLessOilToggle = value;
                                            });
                                            isLessOilToggle = value;
                                            print(isLessOilToggle);
                                          },
                                          activeTrackColor: Color(0xFF001FFF),
                                          inactiveTrackColor: Color(0xFFF2F4F7),
                                          inactiveThumbColor: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.03,),
                              Text('Spice Level',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize14,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(height: h * 0.01,),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                    ),
                                    child: Row(
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: (){
                                              print("Low");
                                              setModalState((){
                                                print("selectedSpiceLevel = Low");
                                                selectedSpiceLevel = 'Low';
                                              });
                                              setState(() {
                                                print("selectedSpiceLevel = Low");
                                                selectedSpiceLevel = 'Low';
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: selectedSpiceLevel == 'Low' ? Colors.black : Color(0xFFF1F1F1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.01, bottom: h * 0.01),
                                                child: Text('Low',
                                                  style: TextStyle(
                                                    fontSize: fontSizes.fontSize12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins_semi_bold',
                                                    color: selectedSpiceLevel == 'Low' ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: (){
                                              print("Medium");
                                              setModalState((){
                                                print("selectedSpiceLevel = Medium");
                                                selectedSpiceLevel = 'Medium';
                                              });
                                              setState(() {
                                                print("selectedSpiceLevel = Medium");
                                                selectedSpiceLevel = 'Medium';
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: selectedSpiceLevel == 'Medium' ? Colors.black : Color(0xFFF1F1F1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.01, bottom: h * 0.01),
                                                child: Text('Medium',
                                                  style: TextStyle(
                                                    fontSize: fontSizes.fontSize12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins_semi_bold',
                                                    color: selectedSpiceLevel == 'Medium' ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: (){
                                              print("High");
                                              setModalState((){
                                                print("selectedSpiceLevel = High");
                                                selectedSpiceLevel = 'High';
                                              });
                                              setState(() {
                                                print("selectedSpiceLevel = High");
                                                selectedSpiceLevel = 'High';
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: selectedSpiceLevel == 'High' ? Colors.black : Color(0xFFF1F1F1),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.01, bottom: h * 0.01),
                                                child: Text('High',
                                                  style: TextStyle(
                                                    fontSize: fontSizes.fontSize12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins_semi_bold',
                                                    color: selectedSpiceLevel == 'High' ? Colors.white : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: h * 0.04,),
                              Text('Custom Preference',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: selectedSpiceLevel == 'Medium' ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: h * 0.015,),

                              Container(
                                height: h * 0.1,
                                width: w,
                                alignment: Alignment.topLeft,
                                padding:
                                EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFF1F1F1),
                                  // color: Colors.red,
                                ),

                                child: TextFormField(
                                  maxLines: null, // Allows the text field to expand with multiple lines
                                  textAlignVertical: TextAlignVertical.top, // Align text to the top
                                  cursorColor: Colors.red,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    labelText: 'e.g. Don’t use cabbage and tomato sauce.',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Color(0xFF606060), // Label color
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF1F1F1),
                                    isCollapsed: true, // Remove extra padding inside the input
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero, // Remove padding from InputDecoration
                                  ),
                                ),
                              ),

                              SizedBox(height: h * 0.03,),

                              Text('Use these preferences',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize14,
                                    color: Colors.black
                                ),
                              ),

                              SizedBox(height: h * 0.02,),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setModalState((){
                                              print("selectedPreference = Once");
                                              selectedPreference = 'Once';
                                            });
                                            setState(() {
                                              selectedPreference = 'Once';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: selectedPreference == 'Once' ? Color(0xFF001FFF) : Color(0xFFF1F1F1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.01, bottom: h * 0.01),
                                              child: Text('Once',
                                                style: TextStyle(
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  color: selectedPreference == 'Once' ? Colors.white : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            setModalState((){
                                              print("selectedPreference = Once");
                                              selectedPreference = 'Save as Default';
                                            });
                                            setState(() {
                                              selectedPreference = 'Save as Default';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: selectedPreference == 'Save as Default' ? Color(0xFF001FFF) : Color(0xFFF1F1F1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: w * 0.08, right: w * 0.08, top: h * 0.01, bottom: h * 0.01),
                                              child: Text('Save as Default',
                                                style: TextStyle(
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  color: selectedPreference == 'Save as Default' ? Colors.white : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: h * 0.02,),
                              Container(
                                width: w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setModalState((){
                                          print("selectedPreference = Once");
                                          selectedPreference = 'Once';
                                        });
                                        setState(() {
                                          selectedPreference = 'Once';
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.45,
                                        height: h * 0.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Text('Discard',
                                            style: TextStyle(
                                              fontSize: fontSizes.fontSize16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_semi_bold',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        setModalState((){
                                          print("selectedPreference = Once");
                                          selectedPreference = 'Save as Default';
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.45,
                                        height: h * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xFF001FFF),
                                        ),
                                        child: Center(
                                          child: Text('Save',
                                            style: TextStyle(
                                              fontSize: fontSizes.fontSize16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_semi_bold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              SizedBox(height: h * 0.02,),

                            ],
                          ),
                        ),



                      ],
                    ),

                  ),
                );
              }
          );
        }
    );
  }

}
