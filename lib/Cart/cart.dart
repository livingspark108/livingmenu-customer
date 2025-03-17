import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Cart/addressBook.dart';
import 'package:living_menu_mobile/Cart/cartOrderPlace.dart';
import 'package:living_menu_mobile/Cart/cartSelectAddress.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/CustomItems/dottedBorderConntainer.dart';
import 'package:living_menu_mobile/DineIn/dineInPlaceOrder.dart';
import 'package:living_menu_mobile/Explore/explore.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:living_menu_mobile/Reward/promoCodeRewards.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:living_menu_mobile/TakeAway/takeawayOrderPlace.dart';
import 'package:living_menu_mobile/TakeAway/takeawayTime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/appFontSizes.dart';
import '../CustomItems/customCircularProgressIndicator.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart>{
  late double w, h;
  bool isDeliverySelected = true;
  bool isPrimeChecked = false;
  List<int> itemCounts = [1, 1, 1];
  late LatLng _userLatLong;
  Position? _currentPosition;
  String selectedLocation = '';
  bool _isLoading = true;
  bool isDineIn = false;

  bool _isPreferenceOpen = false;
  bool isNongToggle = false;
  bool isLessOilToggle = false;
  String selectedSpiceLevel = 'Low';
  String selectedPreference = 'Once';
  bool isCouponApplied = true;

  void updateSelectedLocation(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  getCurrentLocation() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // await Future.delayed(Duration(seconds: 10));
    // await Future.delayed(Duration(milliseconds: 100));
    // Request location permission
    if (await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }

    // await Future.delayed(Duration(seconds: 10));
    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;

      // Set the user latitude and longitude
      _userLatLong = LatLng(
          _currentPosition!.latitude, _currentPosition!.longitude);

      _isLoading = false; // Hide loading indicator after location is fetched
    });
  }

  Future<void> getDineIn() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    final prefs = await SharedPreferences.getInstance();
    isDineIn = prefs.getBool('isDineIn')!;
    print('isDineIn: $isDineIn');
    setState(() {
      _isLoading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    getDineIn();
    getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return !isDineIn ? Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          height: h,
          width: w,
          child: Stack(
            children: [
              Column(
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
                              SizedBox(width: w * 0.18,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isDeliverySelected = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isDeliverySelected ? Color(0xFF000000) : Color(0xFFF1F1F1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.01, bottom: h * 0.01),
                                          child: Text('Delivery',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w600,
                                                color: isDeliverySelected ? Colors.white : Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
        
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isDeliverySelected = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: !isDeliverySelected ? Color(0xFF000000) : Color(0xFFF1F1F1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.01, bottom: h * 0.01),
                                          child: Text('Takeaway',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w600,
                                                color: !isDeliverySelected ? Colors.white : Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.01,),
                        Container(
                          width: w,
                          height: h * 0.001,
                          color: Color(0xFFF1F1F1),
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
                      ],
                    ),
                  ),
        
        
        
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cart items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  /*Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.025, right: w * 0.025, top: h * 0.0125, bottom: h * 0.0125),
                                      child: SvgPicture.asset('assets/icons/arrow_right_black.svg'),
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index){
                                  return _buildCartItems(index);
                                }
                            ),
        
                            SizedBox(height: h * 0.02,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(MainScreen()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: w * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: w * 0.03,),
                                        SvgPicture.asset('assets/icons/add_black.svg'),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.02, right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                          child: Text('Add more items',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.02,),
                            Container(
                              height: h * 0.01,
                              color: Color(0xFFF1F1F1),
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
                                            /* setState(() {
                                              _isPreferenceOpen = true;
                                            });*/
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
        
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, top: h * 0.015),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Complete Your Cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizes.fontSize24,
                                      fontFamily: 'Supreme_bold'
                                  ),
                                ),
                              ),
                            ),
        
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                              child: SizedBox(
                                height: h * 0.22,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index){
                                      return Row(
                                        children: [
                                          _buildCompleteCartItem(),
                                          SizedBox(width: w * 0.03,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),
        
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, top: h * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Our Picks for You',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizes.fontSize24,
                                      fontFamily: 'Supreme_bold'
                                  ),
                                ),
                              ),
                            ),
        
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                              child: SizedBox(
                                height: h * 0.22,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index){
                                      return Row(
                                        children: [
                                          _buildCompleteCartItem(),
                                          SizedBox(width: w * 0.03,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),
        
                            // SizedBox(height: h * 0.02,),
                            Container(
                              height: h * 0.01,
                              color: Color(0xFFF1F1F1),
                            ),
        
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                                  child: Text(!isCouponApplied ? 'Summary' : 'Coupon Applied',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                !isCouponApplied ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PromoCodeRewards()));
                                  },
                                  child: Container(
                                    width: w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.025, bottom: h * 0.025),
                                      child: Container(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset('assets/icons/promo_badge.svg'),
                                                SizedBox(width: w * 0.02,),
                                                Text('Promo codes, rewards & gift cards',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins_regular',
                                                      fontSize: fontSizes.fontSize14,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SvgPicture.asset('assets/icons/right_arrow.svg')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ): Padding(
                                  padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.02, left: w * 0.04,),
                                  child: DottedBorderContainer(
                                      width: w * 0.8,
                                      height: h * 0.062,
                                    borderRadius: 10,
                                    screenWidth: w,
                                    screenHeight: h,
                                  ),
                                ),
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
                                SizedBox(height: h * 0.01,),
                                Container(
                                  height: h * 0.001,
                                  width: w,
                                  color: Color(0xFFF1F1F1),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Savings',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            fontFamily: 'Poppins_regular',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                      Text('₹12.52',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            fontFamily: 'Poppins_regular',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h * 0.01,),
                                Container(
                                  height: h * 0.001,
                                  width: w,
                                  color: Color(0xFFF1F1F1),
                                ),
                                SizedBox(height: h * 0.17,),
                              ],
                            )
        
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: h * 0.1,
                    child: Column(
                      children: [
                        Container(
                          height: h * 0.001,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPrimeChecked = !isPrimeChecked; // Toggle checkbox state
                                  });
                                },
                                child: SvgPicture.asset(
                                  isPrimeChecked ? 'assets/icons/checked_ractangle.svg' : 'assets/icons/unchecked_ractangle.svg',  // Toggle between images
                                  fit: BoxFit.cover,
        
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Save ₹20.89 on this order with Prime',
                                      style: TextStyle(
                                        fontFamily: 'Poppins_semi_bold',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text('Get ₹0 delivery fees and lower services fees. Plus, get Max on us, included with Annual Plan.',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF606060)
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.025),
                          child: GestureDetector(
                            onTap: (){
                              print('isDineIn: $isDineIn');

                              if(!isDineIn) {
                                if(!isDeliverySelected){
                                  showTakeawayPopup();
                                }else {
                                  Navigator.push(context,
                                      AnimatedRoute.createRouteRightToLeft(
                                          AddressBook()));
                                }
                              }else {
                                Navigator.push(context,
                                    AnimatedRoute.createRouteRightToLeft(
                                        DineInPlaceOrder(latLong: _userLatLong,)));
                              }

                            },
                            child: Container(
                              height: h * 0.05,
                              width: w,
                              decoration: BoxDecoration(
                                  color: Color(0xFF001FFF),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Continue',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semi_bold',
                                          fontSize: fontSizes.fontSize16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),
                                    ),
                                    Text('₹198.56',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize16,
                                          fontWeight: FontWeight.w600,
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
        ),
      ),
    ) :









    // DineIn Part Start

    Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          height: h,
          width: w,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
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
                                      Text('Table Number 32',
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
                        Container(
                          width: w,
                          height: h * 0.001,
                          color: Color(0xFFF1F1F1),
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
                      ],
                    ),
                  ),



                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Cart items',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  /*Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.025, right: w * 0.025, top: h * 0.0125, bottom: h * 0.0125),
                                      child: SvgPicture.asset('assets/icons/arrow_right_black.svg'),
                                    ),
                                  )*/
                                ],
                              ),
                            ),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index){
                                  return _buildCartItems(index);
                                }
                            ),

                            SizedBox(height: h * 0.02,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(MainScreen()));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: w * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: w * 0.03,),
                                        SvgPicture.asset('assets/icons/add_black.svg'),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.02, right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                          child: Text('Add more items',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.02,),
                            Container(
                              height: h * 0.01,
                              color: Color(0xFFF1F1F1),
                            ),

                           /* Padding(
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
                            ),*/

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, top: h * 0.015),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Complete Your Cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizes.fontSize24,
                                      fontFamily: 'Supreme_bold'
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                              child: SizedBox(
                                height: h * 0.22,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index){
                                      return Row(
                                        children: [
                                          _buildCompleteCartItem(),
                                          SizedBox(width: w * 0.03,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, top: h * 0.005),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Our Picks for You',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizes.fontSize24,
                                      fontFamily: 'Supreme_bold'
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04),
                              child: SizedBox(
                                height: h * 0.22,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index){
                                      return Row(
                                        children: [
                                          _buildCompleteCartItem(),
                                          SizedBox(width: w * 0.03,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ),

                            // SizedBox(height: h * 0.02,),
                            Container(
                              height: h * 0.01,
                              color: Color(0xFFF1F1F1),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                                  child: Text('Summary',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PromoCodeRewards()));
                                  },
                                  child: Container(
                                    width: w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.025, bottom: h * 0.025),
                                      child: Container(
                                        width: w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset('assets/icons/promo_badge.svg'),
                                                SizedBox(width: w * 0.02,),
                                                Text('Promo codes, rewards & gift cards',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins_regular',
                                                      fontSize: fontSizes.fontSize14,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SvgPicture.asset('assets/icons/right_arrow.svg')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
                                SizedBox(height: h * 0.01,),
                                Container(
                                  height: h * 0.001,
                                  width: w,
                                  color: Color(0xFFF1F1F1),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Savings',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            fontFamily: 'Poppins_regular',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                      Text('₹12.52',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            fontFamily: 'Poppins_regular',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: h * 0.01,),
                                Container(
                                  height: h * 0.001,
                                  width: w,
                                  color: Color(0xFFF1F1F1),
                                ),
                                SizedBox(height: h * 0.17,),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    height: h * 0.1,
                    child: Column(
                      children: [
                        Container(
                          height: h * 0.001,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPrimeChecked = !isPrimeChecked; // Toggle checkbox state
                                  });
                                },
                                child: SvgPicture.asset(
                                  isPrimeChecked ? 'assets/icons/checked_ractangle.svg' : 'assets/icons/unchecked_ractangle.svg',  // Toggle between images
                                  fit: BoxFit.cover,

                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Save ₹20.89 on this order with Prime',
                                      style: TextStyle(
                                        fontFamily: 'Poppins_semi_bold',
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Text('Get ₹0 delivery fees and lower services fees. Plus, get Max on us, included with Annual Plan.',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF606060)
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.025),
                          child: GestureDetector(
                            onTap: (){
                              // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(CartOrderPlace()));
                              if(!isDineIn) {
                                Navigator.push(context,
                                    AnimatedRoute.createRouteRightToLeft(
                                        AddressBook()));
                              }else {
                                Navigator.push(context,
                                    AnimatedRoute.createRouteRightToLeft(
                                        DineInPlaceOrder(latLong: _userLatLong)));
                              }
                              // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(CartSelectAddress(latLong: _userLatLong)));
                            },
                            child: Container(
                              height: h * 0.05,
                              width: w,
                              decoration: BoxDecoration(
                                  color: Color(0xFF001FFF),
                                  borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Continue',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_semi_bold',
                                          fontSize: fontSizes.fontSize16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                      ),
                                    ),
                                    Text('₹198.56',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize16,
                                          fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }













  /*@override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
        child: CustomCircularProgressIndicator(
        size: 60.0,
        dotSize: 10.0,
        dotColor: Color(0xFFF1F1F1),
        dotCount: 8,
        duration: Duration(seconds: 2),
      ),
      ) :Container(
        height: h,
        width: w,
        child: Stack(
          children: [
            Column(
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
                            SizedBox(width: w * 0.18,),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isDeliverySelected = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isDeliverySelected ? Color(0xFF000000) : Color(0xFFF1F1F1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.01, bottom: h * 0.01),
                                        child: Text('Delivery',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontSize: fontSizes.fontSize12,
                                            fontWeight: FontWeight.w600,
                                            color: isDeliverySelected ? Colors.white : Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isDeliverySelected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !isDeliverySelected ? Color(0xFF000000) : Color(0xFFF1F1F1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06, top: h * 0.01, bottom: h * 0.01),
                                        child: Text('Takeaway',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w600,
                                              color: !isDeliverySelected ? Colors.white : Colors.black
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.01,),
                      Container(
                        width: w,
                        height: h * 0.001,
                        color: Color(0xFFF1F1F1),
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
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }*/



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








  /*void _ShowPreferenceItem(BuildContext context){
    AppFontSizes fontSizes = AppFontSizes(context);
    showModalBottomSheet(
      // isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: h * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8)
                          )
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: h * 0.02,),
                            Container(
                              width: w * 0.35,
                              height: h * 0.005,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          width: w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: h * 0.02,),

                              // I want to set below container before SingleChildScrollView
                              *//*Container(
                                width: w * 0.35,
                                height: h * 0.005,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.circular(10)
                                  // color: Colors.black
                                ),
                              ),*//*



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
                                    Row(
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
                                    SizedBox(height: h * 0.03,),
                                    Row(
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
                                                    *//*setState(() {
                                                print("selectedSpiceLevel = Low");
                                                selectedSpiceLevel = 'Low';
                                              });*//*
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
                                                    *//*setState(() {
                                                print("selectedSpiceLevel = Medium");
                                                selectedSpiceLevel = 'Medium';
                                              });*//*
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
                                                    *//*setState(() {
                                                print("selectedSpiceLevel = High");
                                                selectedSpiceLevel = 'High';
                                              });*//*
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
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        maxLines: null, // Allows the text field to expand with multiple lines
                                        textAlignVertical: TextAlignVertical.top,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'e.g. Don’t use cabbage and tomato sauce.',
                                          labelStyle: TextStyle(
                                            // Custom style for the label
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins_regular',
                                            color: Color(0xFF606060), // Label color
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF1F1F1),
                                          isCollapsed: true,
                                          border: InputBorder.none,
                                        ).copyWith(isDense: true),
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
                                                  *//* setState(() {
                                              selectedPreference = 'Once';
                                            });*//*
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
                                                  *//*setState(() {
                                              selectedPreference = 'Save as Default';
                                            });*//*
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
                                              *//* setState(() {
                                          selectedPreference = 'Once';
                                        });*//*
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
                                              *//*setModalState((){
                                          print("selectedPreference = Once");
                                          selectedPreference = 'Save as Default';
                                        });*//*
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
                      ]),

                    ),
                  ],
                );
              }
          );
        }
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

  Widget _buildCartItems(int index){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Padding(
      padding: EdgeInsets.only(top: h * 0.02),
      child: Container(
        width: w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/pizza.png',
                          height: h * 0.07,
                          width: w * 0.16,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: w * 0.04,),
                      Container(
                        width: w * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cheese Pizza',
                              style: TextStyle(
                                fontFamily: 'Poppins_semi_bold',
                                fontSize: fontSizes.fontSize16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                height: 1.5
                              ),
                            ),
                            Text('Corn, Mozzarella Cheese, Mint Mayonnaise',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Color(0xFF606060),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 0,
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: w * 0.04,),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                          onTap: (){
                            setState(() {
                              if(itemCounts[index] > 1){
                                itemCounts[index]--;
                              }
                            });
                          },
                            child: Container(
                              height: h * 0.03,
                              child: SvgPicture.asset(
                                  itemCounts[index] > 1 ? 'assets/icons/subtract.svg' : 'assets/icons/delete_black.svg'),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.01, bottom: h * 0.01),
                          child: Text(itemCounts[index].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize16,
                                fontFamily: 'Supreme_bold'
                            ),
                          ),
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                          onTap: (){
                            setState(() {
                              itemCounts[index]++;
                            });
                          },
                            child: Container(
                              height: h * 0.03,
                                child: SvgPicture.asset('assets/icons/add_black.svg'))
                        ),
                        SizedBox(width: w * 0.04,),
                      ],
                    ),
                  )
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
      ),
    );
  }

  Widget _buildCompleteCartItem(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.22,
      width: w * 0.43,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: h * 0.15,
                width: w * 0.43,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/images/pizza.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                  right: 0,
                  child: SvgPicture.asset('assets/icons/add.svg')
              ),
            ],
          ),
          SizedBox(height: h * 0.01,),
          Row(
            children: [
              SvgPicture.asset('assets/icons/veg_icon.svg'),
              SizedBox(width: w * 0.02,),
              Text('Cheese Pizza',
                style: TextStyle(
                  fontFamily: 'Poppins_regular',
                  fontSize: fontSizes.fontSize14,
                  fontWeight: FontWeight.w500
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Row(
            children: [
              /*Image.asset('assets/Veg_icon.png',
                        width: w * 0.03,
                      ),*/
              /*SvgPicture.asset('assets/icons/veg_icon.svg',
                width: w * 0.03,
              ),
              SizedBox(width: w * 0.01,),*/
              Text('4.3',
                style: TextStyle(
                    fontSize: fontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins_regular',
                    color: Color(0xFF606060)
                  // height: 1
                ),
              ),
              SizedBox(width: w * 0.01,),
              /*Image.asset('assets/star_new.png',
                        width: w * 0.03,
                      ),*/
              SvgPicture.asset('assets/icons/Star.svg',
                width: w * 0.03,
              ),
              SizedBox(width: w * 0.01,),
              Text('(30K+)',
                style: TextStyle(
                    fontSize: fontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins_regular',
                    color: Color(0xFF606060)
                  // height: 1
                ),
              ),
              SizedBox(width: w * 0.01,),
              Container(
                height: h * 0.004,
                width: w * 0.008,
                color: Colors.black,
              ),
              SizedBox(width: w * 0.01,),
              /*Image.asset('assets/watch_new.png',
                        width: w * 0.03,
                      ),*/
              SvgPicture.asset('assets/icons/time_icon.svg',
                width: w * 0.03,
              ),
              // SizedBox(width: w * 0.01,),
              Text('28 min',
                style: TextStyle(
                    fontSize: fontSizes.fontSize12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins_regular',
                    color: Color(0xFF606060)
                  // height: 1
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool isStandardSelected = false;

  Widget showTakeawayDialog(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: w * 0.9,
        height: h * 0.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pickup Schedule',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Supreme_bold',
                      fontSize: fontSizes.fontSize24,
                      color: Colors.black
                    ),
                  ),
                  Text('Click on save to confirm changes.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        fontSize: fontSizes.fontSize14,
                        color: Color(0xFF939393)
                    ),
                  ),



                  SizedBox(height: h * 0.012,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isStandardSelected = true;
                          });
                        },
                        child: Container(
                          width: w * 0.35,
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
                      InkWell(
                        onTap: (){
                          setState(() {
                            isStandardSelected = false;
                          });
                          // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                        },
                        child: Container(
                          width: w * 0.35,
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
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSizes.fontSize10,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),
                                    SizedBox(height: h * 0.003,),
                                    Text('+ ₹29.99',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSizes.fontSize10,
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
          ],
        ),
      ),
    );
  }

  /*void showTakeawayPopup() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows closing the dialog by tapping outside
      builder: (BuildContext context) {
        return showTakeawayDialog(); // Your dialog widget
      },
    );
  }*/

  void showTakeawayPopup() {
    AppFontSizes fontSizes = AppFontSizes(context);
    showDialog(
      context: context,
      barrierDismissible: true, // Allows closing the dialog by tapping outside
      builder: (BuildContext context) {
        bool isStandardSelected = false; // Local state for the dialog
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: w * 0.9,
                height: h * 0.32,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pickup Schedule',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Supreme_bold',
                                fontSize: fontSizes.fontSize24,
                                color: Colors.black
                            ),
                          ),
                          Text('Click on save to confirm changes.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize14,
                                color: Color(0xFF939393)
                            ),
                          ),



                          SizedBox(height: h * 0.012,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isStandardSelected = true;
                                  });
                                },
                                child: Container(
                                  width: w * 0.35,
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
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    isStandardSelected = false;
                                  });
                                  // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                                },
                                child: Container(
                                  width: w * 0.35,
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
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: fontSizes.fontSize10,
                                                  fontFamily: 'Poppins_regular',
                                                  color: Colors.black
                                              ),
                                            ),
                                            SizedBox(height: h * 0.003,),
                                            Text('+ ₹29.99',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: fontSizes.fontSize10,
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

                    SizedBox(height: h * 0.02,),
                    Container(
                      height: h * 0.001,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),

                    SizedBox(height: h * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.1, right: w * 0.02, top: h * 0.01, bottom: h * 0.01),
                              child: Text('Discard',

                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_semi_bold',
                                    fontSize: fontSizes.fontSize16,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.06,),
                        GestureDetector(
                          onTap: (){
                            // onConfirm();
                            Navigator.of(context).pop();
                            if(isStandardSelected){
                              Navigator.push(context,
                                  AnimatedRoute.createRouteRightToLeft(
                                      TakeawayOrderPlace()));
                            }else {
                              Navigator.push(context,
                                  AnimatedRoute.createRouteRightToLeft(
                                      TakeawayTime()));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Color(0xFF001FFF),
                              color: Color(0xFF001FFF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: h * 0.01, bottom: h * 0.01),
                              child: Text('Continue',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_semi_bold',
                                    fontSize: fontSizes.fontSize16,
                                    color: Colors.white
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
            );
          },
        );
      },
    );
  }


}
