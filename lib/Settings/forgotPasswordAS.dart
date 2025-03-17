import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class ForgotPasswordAS extends StatefulWidget {
  const ForgotPasswordAS({super.key});

  @override
  State<ForgotPasswordAS> createState() => _ForgotPasswordAS();
}

class _ForgotPasswordAS extends State<ForgotPasswordAS>{
  late double w,h;
  bool oldPasswordSecure = true;
  bool newPasswordSecure = true;
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
                Text('Forgot Password',
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

          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.01,),
                Text('Mobile Number',
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
                    obscureText: oldPasswordSecure,
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

                SizedBox(height: h * 0.01,),
                Text('Otp',
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
                    obscureText: oldPasswordSecure,
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

                SizedBox(height: h * 0.01,),
                Text('New Password',
                  style: TextStyle(
                      fontSize: fontSizes.fontSize12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black
                  ),
                ),
                SizedBox(height: h * 0.01,),
                Stack(
                  children: [
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
                        obscureText: newPasswordSecure,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                          // suffixIcon: SvgPicture.asset('assets/icons/eye.svg',),
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
                    Positioned(
                      right: w * 0.03,
                      top: h * 0.01,
                      child: GestureDetector(
                          onTap: (){
                            setState(() {
                              if(newPasswordSecure){
                                newPasswordSecure = false;
                              }else {
                                newPasswordSecure = true;
                              }
                            });
                          },
                          child: !newPasswordSecure ? SvgPicture.asset('assets/icons/eye.svg',) : SvgPicture.asset('assets/icons/eye_disable.svg',)
                      ),
                    )
                  ],
                ),

                SizedBox(height: h * 0.01,),
                Text('Confirm New Password',
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
                      hintText: 'Re-enter new password',
                      labelText: 'Re-enter new password',
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
                SizedBox(height: h * 0.02,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ChangePassword()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                          child: Text('Update',
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
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
