import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Settings/forgotPasswordAS.dart';
import 'package:living_menu_mobile/network/apiService.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';
import '../CustomItems/errorPopup.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>{
  late double w,h;
  bool oldPasswordSecure = true;
  bool newPasswordSecure = true;
  ApiService apiService = ApiService();
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();


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
                Text('Change Password',
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
                Text('Old Password',
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
                    controller: oldPassController,
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
                        controller: newPassController,
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
                    controller: confirmPassController,
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
                        if(oldPassController.text.isEmpty){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter old password.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                        }else if(newPassController.text.isEmpty || newPassController.text.length < 8){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter 8 character new password.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                        }else if(confirmPassController.text.isEmpty){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter confirm password.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                        }else if(newPassController.text != confirmPassController.text){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'New password and confirm password did not match.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                        }else {
                          apiService.changePassword(
                              context, oldPassController.text,
                              newPassController.text).then((value) {

                                final response = value;
                                final data = jsonDecode(response.body);
                                ErrorPopup.showGlobalPopup(
                                    context: context,
                                    title: 'Success',
                                    titleColor: Colors.green,
                                    message: data['message'],
                                    buttonText: 'OK',
                                    buttonTextColor: Colors.black
                                );

                          });
                        }
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
                    SizedBox(width: w * 0.02,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPasswordAS()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                          child: Text('Forgot Password',
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
                )

              ],
            ),
          )
        ],
      ),
    );
  }

}
