import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';

import '../Constants/appFontSizes.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy>{
  late double w, h;
  bool isLocationAccess = true;

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
                Text('Privacy',
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
          SizedBox(height: h * 0.005,),

          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location Access',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_semi_bold',
                        color: Colors.black,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isLocationAccess,
                        onChanged: (bool value) {
                          setState(() {
                            isLocationAccess = value;
                          });
                          isLocationAccess = value;
                          print(isLocationAccess);
                        },
                        activeTrackColor: Color(0xFF001FFF),
                        inactiveTrackColor: Color(0xFFF2F4F7),
                        inactiveThumbColor: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: w * 0.7,
                  child: Text(AppStrings.LOCATION_ACCESS_MSG,
                    style: TextStyle(
                      fontSize: fontSizes.fontSize12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular',
                      color: Color(0xFF606060),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.02,),
                Text('Privacy Policy',
                  style: TextStyle(
                    fontSize: fontSizes.fontSize14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins_semi_bold',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: h * 0.01,),
                Container(
                  width: w * 0.8,
                  child: Text(AppStrings.PRIVACY_POLICY_MSG,
                    style: TextStyle(
                      fontSize: fontSizes.fontSize12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular',
                      color: Color(0xFF606060),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.015,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferralStatus()));
                      },
                      child: Container(
                        height: h * 0.045,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF1F1F1)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.03),
                          child: Row(
                            children: [
                              Text('Learn More',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: Colors.black,
                                ),
                              ),
                              // SizedBox(width: w * 0.02,),
                              SvgPicture.asset('assets/icons/arrow_insert.svg'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),

    );
  }

}
