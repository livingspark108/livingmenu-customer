import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Cart/addressBook.dart';
import 'package:living_menu_mobile/Cart/cartSelectAddress.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Delivery/deliveryTime.dart';
import 'package:living_menu_mobile/TakeAway/takeawayTrackOrder.dart';
import 'package:living_menu_mobile/TrackOrder/trackOrder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Constants/appFontSizes.dart';

class TakeawayOrderPlace extends StatefulWidget {
  TakeawayOrderPlace({Key? key}) : super(key: key);

  // LatLng latLong;

  @override
  State<TakeawayOrderPlace> createState() => _TakeawayOrderPlaceState();
}

class _TakeawayOrderPlaceState extends State<TakeawayOrderPlace>{
  late double w, h;
  bool isStandardSelected = true;
  bool isSendGiftChecked = false;
  bool isUseWallet = true;
  late LatLng _restaurantLatLong;
  bool isReceiptOpen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restaurantLatLong = LatLng(26.8311, 75.7497);
    // _userLatLong = widget.latLong;
    // print('USER_LAT_LONG_PLACE_ORDER: ${_userLatLong}');
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
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: SvgPicture.asset('assets/icons/header_back.svg'),
                        ),
                      ),
                      SizedBox(width: w * 0.24,),
                      Column(
                        children: [
                          Text('Continue Shopping',
                            style: TextStyle(
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF606060),
                                height: 1
                            ),
                          ),
                          Text('Govindas Restaurant',
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
                SizedBox(height: h * 0.004,),
                Container(
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
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/watch.svg'),
                      SizedBox(width: w * 0.04,),
                      Expanded(
                        child: Text('19 min left to place your delivery order on living menu online order app. The restaurant will be closed at 10:30 pm.',
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



                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: h * 0.16,
                                  width: w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey
                                      )
                                  ),
                                ),
                                SizedBox(height: h * 0.012,),
                                Text('Takeaway Date & Time',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize14,
                                      fontFamily: 'Poppins_semi_bold'
                                  ),
                                ),
                                SizedBox(height: h * 0.012,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isStandardSelected = true;
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.44,
                                        height: h * 0.125,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: isStandardSelected ? Colors.black : Color(0xFFF1F1F1),
                                                width: isStandardSelected ? w * 0.005 : w * 0.0025
                                            )
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: w * 0.03, top: h * 0.015, right: w * 0.03),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Standard',
                                                        style: TextStyle(
                                                            fontFamily: 'Poppins_semi_bold',
                                                            fontSize: fontSizes.fontSize15,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                      SvgPicture.asset(
                                                          isStandardSelected ? 'assets/icons/rounded_checked.svg' : 'assets/icons/rounded_unchecked.svg'
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: h * 0.003,),
                                                  Text('25-35 mins',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: fontSizes.fontSize12,
                                                        fontFamily: 'Poppins_regular',
                                                        color: Color(0xFF606060)
                                                    ),
                                                  ),
                                                  SizedBox(height: h * 0.003,),
                                                  Text('Instant',
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

                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isStandardSelected = false;
                                        });
                                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                                      },
                                      child: Container(
                                        width: w * 0.44,
                                        height: h * 0.125,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: !isStandardSelected ? Colors.black : Color(0xFFF1F1F1),
                                                width: !isStandardSelected ? w * 0.005 : w * 0.0025
                                            )
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: w * 0.03, top: h * 0.015, right: w * 0.03),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('Custom',
                                                            style: TextStyle(
                                                                fontFamily: 'Poppins_semi_bold',
                                                                fontSize: fontSizes.fontSize15,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black
                                                            ),
                                                          ),
                                                          SizedBox(width: w * 0.02,),
                                                          SvgPicture.asset('assets/icons/right_arrow.svg')
                                                        ],
                                                      ),
                                                      SvgPicture.asset(
                                                          !isStandardSelected ? 'assets/icons/rounded_checked.svg' : 'assets/icons/rounded_unchecked.svg'
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: h * 0.003,),
                                                  Text('25/10/24 (14:40)',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: fontSizes.fontSize12,
                                                        fontFamily: 'Poppins_regular',
                                                        color: Color(0xFF606060)
                                                    ),
                                                  ),
                                                  SizedBox(height: h * 0.003,),
                                                  Text('Scheduled delivery',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: fontSizes.fontSize12,
                                                        fontFamily: 'Poppins_regular',
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                  SizedBox(height: h * 0.003,),
                                                  Text('+ ₹29.99',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: fontSizes.fontSize12,
                                                        fontFamily: 'Poppins_regular',
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.03, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AddressBook()));
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: w * 0.05,
                                                child: SvgPicture.asset('assets/icons/restaurant_black.svg')

                                            ),
                                            SizedBox(width: w * 0.04,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Shri Sai Restaurant & Bar',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: fontSizes.fontSize14,
                                                      fontFamily: 'Poppins_regular',
                                                      color: Colors.black
                                                  ),
                                                ),
                                                Text('132, Vaishali Nagar, Jaipur - 302021',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: fontSizes.fontSize12,
                                                      fontFamily: 'Poppins_regular',
                                                      color: Color(0xFF606060)
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SvgPicture.asset('assets/icons/right_arrow.svg')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.015,),
                          Container(
                            height: h * 0.001,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),


                          Padding(
                            padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: w * 0.05,
                                            child: SvgPicture.asset('assets/icons/hand_it_to_me.svg')
                                        ),
                                        SizedBox(width: w * 0.04,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('#2345385632',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fontSizes.fontSize14,
                                                  fontFamily: 'Poppins_regular',
                                                  color: Colors.black
                                              ),
                                            ),
                                            Text('Give this order ID to get your order',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: fontSizes.fontSize12,
                                                  fontFamily: 'Poppins_regular',
                                                  color: Color(0xFF606060)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset('assets/icons/right_arrow.svg')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.015,),
                          Container(
                            height: h * 0.001,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: h * 0.024, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: w * 0.05,
                                            child: SvgPicture.asset('assets/icons/call_icon.svg')
                                        ),
                                        SizedBox(width: w * 0.04,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('+91 9803554735',
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
                                    SvgPicture.asset('assets/icons/right_arrow.svg')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.024,),
                          Container(
                            height: h * 0.001,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),


                          Padding(
                            padding: EdgeInsets.only(top: h * 0.024, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              if(isSendGiftChecked){
                                                isSendGiftChecked = false;
                                              }else {
                                                isSendGiftChecked = true;
                                              }
                                            });
                                          },
                                          child: Container(
                                              width: w * 0.05,
                                              child: SvgPicture.asset(
                                                  isSendGiftChecked ? 'assets/icons/checked_ractangle.svg' : 'assets/icons/unchecked_ractangle.svg'
                                              )
                                          ),
                                        ),
                                        SizedBox(width: w * 0.04,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Send as Gift',
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

                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.024,),
                          Container(
                            height: h * 0.008,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),


                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              setState(() {
                                if(!isReceiptOpen){
                                  isReceiptOpen = true;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.024, left: w * 0.04, right: w * 0.04),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: w * 0.05,
                                              child: SvgPicture.asset('assets/icons/view_invoice.svg')
                                          ),
                                          SizedBox(width: w * 0.04,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('View Order Summery',
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
                                      Row(
                                        children: [
                                          Text('₹198.56',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize14,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                          SizedBox(width: w * 0.025,),
                                          SvgPicture.asset('assets/icons/right_arrow.svg'),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),


                          Padding(
                            padding: EdgeInsets.only(top: h * 0.04, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        /*Container(
                                            width: w * 0.05,
                                            child: SvgPicture.asset('assets/icons/view_invoice.svg')
                                        ),
                                        SizedBox(width: w * 0.04,),*/
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Payment',
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
                                    Row(
                                      children: [
                                        Text('Razorpay',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                              fontFamily: 'Poppins_regular',
                                              color: Color(0xFF606060)
                                          ),
                                        ),
                                        SizedBox(width: w * 0.025,),
                                        SvgPicture.asset('assets/icons/right_arrow.svg'),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: h * 0.2,)




                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
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
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(TakeawayTrackOrder(latLong: _restaurantLatLong)));
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






          Positioned(
              bottom: h * 0.02,
              child: Visibility(
                visible: isReceiptOpen,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Container(
                    height: h * 0.77,
                    width: w * 0.92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 50,
                          spreadRadius: 20,
                          color:
                          Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          if(isReceiptOpen){
                                            isReceiptOpen = false;
                                          }
                                        });
                                      },
                                      child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                                  ),
                                  SizedBox(height: h * 0.02,),
                                  Container(
                                    height: h * 0.35,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: 9, // Make sure to set the item count
                                      itemBuilder: (context, index) {
                                        return _buildReceiptItem();
                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.03,),
                            Container(
                              width: w,
                              height: h * 0.001,
                              color: Color(0xFFF1F1F1),
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹120.00',
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

                            SizedBox(height: h * 0.006,),
                            Container(
                              color: Color(0xFFEEF0FF),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.005, bottom: h * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Fee',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizes.fontSize14,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),

                                    Text('₹0.00',
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
                            ),
                            SizedBox(height: h * 0.006,),
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Platform Fee',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹3.21',
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

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Restaurant Charges',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹10.41',
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

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Estimated Tax',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹83.04',
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
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_semi_bold',
                                        color: Colors.black
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _buildTextWithLine('₹210.04'),
                                      SizedBox(width: w * 0.005,),
                                      Text('₹198.56',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize16,
                                            fontFamily: 'Poppins_semi_bold',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),



                          ],
                        ),


                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(isReceiptOpen){
                                    isReceiptOpen = false;
                                  }else {
                                    isReceiptOpen = true;
                                  }
                                });
                              },
                              child: Container(
                                height: h * 0.07,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h * 0.001,
                                      width: w,
                                      color: Color(0xFFF1F1F1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.025),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            isReceiptOpen ? 'View less details' : 'View all details',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset(
                                              isReceiptOpen ? 'assets/icons/up_arrow_black.svg' : 'assets/icons/down_arrow_black.svg'
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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

  Widget _buildReceiptItem(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('1',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizes.fontSize12,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black
                  ),
                ),
                SizedBox(width: w * 0.02,),
                Text('Double Whopper',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizes.fontSize12,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black
                  ),
                ),
              ],
            ),
            Text('₹56.9',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizes.fontSize12,
                  fontFamily: 'Poppins_regular',
                  color: Colors.black
              ),
            )
          ],
        ),
        SizedBox(height: h * 0.005,),
        Padding(
          padding: EdgeInsets.only(left: w * 0.03),
          child: Text('Add Mustard, Add BQ Sauce',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSizes.fontSize12,
                fontFamily: 'Poppins_regular',
                color: Color(0xFF606060)
            ),
          ),
        ),
        SizedBox(height: h * 0.02,),
      ],
    );
  }

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
