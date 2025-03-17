import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Authentication/login.dart';
import 'package:living_menu_mobile/Cart/addressBook.dart';
import 'package:living_menu_mobile/ComingSoon/comingSoon.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/CustomItems/popupUtils.dart';
import 'package:living_menu_mobile/Error/errorPage.dart';
import 'package:living_menu_mobile/Gift/giftCard.dart';
import 'package:living_menu_mobile/Legal/legals.dart';
import 'package:living_menu_mobile/Orders/myOrders.dart';
import 'package:living_menu_mobile/Payment/paymeny.dart';
import 'package:living_menu_mobile/Privacy/privacyPolicy.dart';
import 'package:living_menu_mobile/Profile/accountSettings.dart';
import 'package:living_menu_mobile/Profile/profile.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';
import 'package:living_menu_mobile/Reward/rewards.dart';
import 'package:living_menu_mobile/Saved/savedItems.dart';
import 'package:living_menu_mobile/Settings/addressListForEdit.dart';
import 'package:living_menu_mobile/Settings/notificationSettings.dart';
import 'package:living_menu_mobile/Wallet/livingMenuWallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/appFontSizes.dart';
import '../Models/ordersModel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super (key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late double w, h;

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all data
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02,),
                    Text('Settings',
                      style: TextStyle(
                        fontFamily: 'Supreme_bold',
                        fontWeight: FontWeight.w700,
                        fontSize: fontSizes.fontSize24
                      ),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.04),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Payment()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                      child: SvgPicture.asset('assets/icons/payments.svg',)
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Payment',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(LivingMenuWallet()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/wallet.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Living Menu Wallet',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(SavedItems()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/bookmark_heart.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Saved Items',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Myorders()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/receipt.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Orders',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ComingSoon()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/boockings.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Bookings',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Rewards()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/reward_black.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Rewards',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),
        
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(GiftCard()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/gift_reedem.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Gift Card',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                  ],
                ),
              ),
              Container(
                width: w,
                height: h * 0.008,
                color: Color(0xFFF1F1F1),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferRestaurant()));
                },
                child: Container(
                  width: w,
                  height: h * 0.08,
                  color: Color(0xFFE1E9FF),
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.045),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: w * 0.06,
                                child: SvgPicture.asset('assets/icons/refer_friends.svg',)
                            ),
                            SizedBox(width: w * 0.03,),
                            Text('Refer a Restaurant, Get ₹1000',
                              style: TextStyle(
                                  fontSize: fontSizes.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular'
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: w * 0.025),
                          child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: w,
                height: h * 0.008,
                color: Color(0xFFF1F1F1),
              ),
        
              Padding(
                padding: EdgeInsets.only(top: h * 0.04, left: w * 0.04),
                child: Text('Account Settings',
                  style: TextStyle(
                    fontSize: fontSizes.fontSize24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Supreme_bold'
                  ),
                ),
              ),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AccountSettings()));
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Manage Account',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular'
                                            ),
                                          ),
                                          Text('Update information and manage your account',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF7B7B7B)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),


                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AddressListForEdit()));
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Address',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular'
                                            ),
                                          ),
                                          Text('Add or remove delivery address',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF7B7B7B)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PrivacyPolicy()));
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Privacy',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular'
                                            ),
                                          ),
                                          Text('Learn about Privacy and manage settings',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF7B7B7B)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(NotificationSettings()));
                      },
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Notifications Settings',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular'
                                            ),
                                          ),
                                          Text('Manage delivery and promotional notifications',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF7B7B7B)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ComingSoon()));
                      },

                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Language and Currency',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular'
                                            ),
                                          ),
                                          Text('Update language, and currency settings',
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF7B7B7B)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.03),
                                    child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03,),
                  Container(
                    width: w,
                    height: h * 0.001,
                    color: Color(0xFFF1F1F1),
                  ),
                ],
              ),
              Container(
                width: w,
                height: h * 0.008,
                color: Color(0xFFF1F1F1),
              ),

              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('More',
                      style: TextStyle(
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          fontSize: fontSizes.fontSize24
                      ),
                    ),

                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: EdgeInsets.only(top: h * 0.04),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: w * 0.06,
                                      child: Image.asset('assets/icons/Prime_enable.png',
                                        height: h * 0.025,
                                      ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Get Living Menu Prime',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: w * 0.06,
                                child: SvgPicture.asset('assets/icons/reward_black.svg',
                                  // width: w * 0.05,
                                  // height: h * 0.05,
                                ),
                              ),
                              SizedBox(width: w * 0.03,),
                              Text('Become a Partner',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular'
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: w * 0.03),
                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                          ),
                        ],
                      ),
                    ),
                   /* SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),*/

                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: EdgeInsets.only(top: h * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: w * 0.06,
                                  child: SvgPicture.asset('assets/icons/reward_black.svg',
                                    // width: w * 0.05,
                                    // height: h * 0.05,
                                  ),
                                ),
                                SizedBox(width: w * 0.03,),
                                Text('Recipes',
                                  style: TextStyle(
                                      fontSize: fontSizes.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular'
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: w * 0.03),
                              child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),*/

                    Visibility(
                      visible: false,
                      child: Padding(
                        padding: EdgeInsets.only(top: h * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: w * 0.06,
                                  child: SvgPicture.asset('assets/icons/reward_black.svg',
                                    // width: w * 0.05,
                                    // height: h * 0.05,
                                  ),
                                ),
                                SizedBox(width: w * 0.03,),
                                Text('Blogs',
                                  style: TextStyle(
                                      fontSize: fontSizes.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular'
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: w * 0.03),
                              child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),

                    /*Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: w * 0.06,
                                child: SvgPicture.asset('assets/icons/reward_black.svg',
                                  // width: w * 0.05,
                                  // height: h * 0.05,
                                ),
                              ),
                              SizedBox(width: w * 0.03,),
                              Text('FAQs',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular'
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: w * 0.03),
                            child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),*/

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Legals()));
                      },
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: w * 0.06,
                                    child: SvgPicture.asset('assets/icons/reward_black.svg',
                                      // width: w * 0.05,
                                      // height: h * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  Text('Legal',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular'
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.03),
                                child: SvgPicture.asset('assets/icons/right_arrow_black.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03,),
                    Container(
                      width: w,
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
                    ),

                  ],
                ),
              ),

              Container(
                width: w,
                height: h * 0.008,
                color: Color(0xFFF1F1F1),
              ),
              Container(
                width: w,
                height: h * 0.08,
                color: Color(0xFFFFD3D3),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.045),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Delete Account',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular'
                        ),
                      ),

                      Text('You wil not be able to recover your account.',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                          color: Color(0xFF7B7B7B)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: w,
                height: h * 0.008,
                color: Color(0xFFF1F1F1),
              ),

              GestureDetector(
                onTap: (){
                  showCustomPopup(
                    context,
                    'Confirm Changes',
                    'Click on save to confirm changes.',
                    'Discard',
                    'Confirm',
                        () {
                      clearAllData();
                      Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(Login()), (route) => false);
                      print('Confirmed!');
                      },
                    Color(0xFFF45601),
                    w * 0.05,
                  );
                },
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.04, left: w * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Logout',
                              style: TextStyle(
                                  fontSize: fontSizes.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                color: Color(0xFFF45601)
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: h * 0.06, left: w * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('version 2.18.0 (647392)',
                          style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF7B7B7B)
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: h * 0.05,)

            ],
          ),
        ),
      ),
    );
  }

}

