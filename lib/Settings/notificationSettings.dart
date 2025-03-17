import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings>{
  late double w,h;
  bool isOrderUpdate = false;
  bool isStoreOffers = false;
  bool isLMOffer = false;
  bool isRecommendation = false;
  bool isReminders = false;
  bool isProductUpdateNews = false;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.07, left: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/icons/header_back.svg')
                ),
                SizedBox(height: h * 0.03,),
                Text('Notification Settings',
                  style: TextStyle(
                    fontSize: fontSizes.fontSize24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Supreme_bold',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.015,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),
          SizedBox(height: h * 0.02,),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isOrderUpdate){
                  isOrderUpdate = false;
                }else {
                  isOrderUpdate = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Updates',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('Order Tracking, Schedule, etc',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isOrderUpdate,
                        onChanged: (bool value) {
                          setState(() {
                            isOrderUpdate = value;
                          });
                          isOrderUpdate = value;
                          print(isOrderUpdate);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

          SizedBox(height: h * 0.02,),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isStoreOffers){
                  isStoreOffers = false;
                }else {
                  isStoreOffers = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Store Offers',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('WhatsApp Updates',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isStoreOffers,
                        onChanged: (bool value) {
                          setState(() {
                            isStoreOffers = value;
                          });
                          isStoreOffers = value;
                          print(isStoreOffers);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

          SizedBox(height: h * 0.02,),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isLMOffer){
                  isLMOffer = false;
                }else {
                  isLMOffer = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Living Menu Offers',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('WhatsApp Updates',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isLMOffer,
                        onChanged: (bool value) {
                          setState(() {
                            isLMOffer = value;
                          });
                          isLMOffer = value;
                          print(isLMOffer);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

          SizedBox(height: h * 0.02,),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isRecommendation){
                  isRecommendation = false;
                }else {
                  isRecommendation = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recommendations',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('WhatsApp & Notifications',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isRecommendation,
                        onChanged: (bool value) {
                          setState(() {
                            isRecommendation = value;
                          });
                          isRecommendation = value;
                          print(isRecommendation);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

          SizedBox(height: h * 0.02,),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isReminders){
                  isReminders = false;
                }else {
                  isReminders = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reminders',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('WhatsApp & Call reminders',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isReminders,
                        onChanged: (bool value) {
                          setState(() {
                            isReminders = value;
                          });
                          isReminders = value;
                          print(isReminders);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

          SizedBox(height: h * 0.02,),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              setState(() {
                if(isProductUpdateNews){
                  isProductUpdateNews = false;
                }else {
                  isProductUpdateNews = true;
                }
              });
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Updates & News',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                          ),
                        ),
                        Text('WhatsApp Promotional Messages',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFF606060),
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isProductUpdateNews,
                        onChanged: (bool value) {
                          setState(() {
                            isProductUpdateNews = value;
                          });
                          isProductUpdateNews = value;
                          print(isProductUpdateNews);
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
          ),
          SizedBox(height: h * 0.02,),

          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),

        ],
      ),
    );
  }

}
