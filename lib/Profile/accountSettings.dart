import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Settings/changePassword.dart';

import '../Constants/appFontSizes.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings>{
  late double w, h;
  bool isNongToggle = false;
  bool isLessOilToggle = false;
  String selectedSpiceLevel = 'Low';
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
                Text('Account Settings',
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

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Basic Details',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: h * 0.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'First Name',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.black
                                      // fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.435,
                                    alignment: Alignment.center,
                                    padding:
                                    EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                      // color: Colors.red,
                                    ),
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.black
                                      // fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.435,
                                    alignment: Alignment.center,
                                    padding:
                                    EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                      // color: Colors.red,
                                    ),
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),
            
                            ],
                          ),
            
                          SizedBox(height: h * 0.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Country',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.black
                                      // fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    padding: EdgeInsets.zero,
                                    /*constraints: BoxConstraints(
                                      maxWidth: w * 0.2, // Adjust based on your layout
                                    ),*/
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CountryCodePicker(
                                          padding: EdgeInsets.zero,
                                          showFlag: false,
                                          initialSelection: 'IN',
                                          // showDropDownButton: true,
                                        ),
                                        SvgPicture.asset('assets/icons/arrow_down_black_small.svg'),
                                        SizedBox(width: w * 0.04,)
                                      ],
                                    ),
                                  ),
            
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize12,
                                        color: Colors.black
                                      // fontSize: 18
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.65,
                                    alignment: Alignment.center,
                                    padding:
                                    EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1),
                                      // color: Colors.red,
                                    ),
                                    child: TextFormField(
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),
            
                            ],
                          ),
            
            
                          SizedBox(height: h * 0.01,),
                          Text('Email',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_regular',
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: h * 0.01,),
                          Container(
                            height: h * 0.05,
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
                              cursorColor: Colors.red,
                              decoration: InputDecoration(
                                // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                labelText: '',
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
                          SizedBox(height: h * 0.012,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ChangePassword()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                                child: Text('Change password',
                                  style: TextStyle(
                                    fontFamily: 'Poppins_semi_bold',
                                    fontWeight: FontWeight.w600,
                                    fontSize: fontSizes.fontSize12,
                                    color: Colors.white
                                  ),
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
                      height: h * 0.001,
                      color: Color(0xFFF1F1F1),
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
                                    setState(() {
            
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
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
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
            
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
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
            
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
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
                            // alignment: Alignment.center,
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

                          SizedBox(height: h * 0.1,)
            
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
