import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/appStrings.dart';
import '../CustomItems/errorPopup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  late double w, h;
  String sentOtpBtnText = 'Send OTP';
  String selectedCountryCode = '+91';
  bool isLoading = false;
  TextEditingController otpController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  ApiService apiService = ApiService();


  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    bool  isLoader = false;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.05, left: w * 0.05, right: w * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: SvgPicture.asset('assets/icons/header_back.svg',)
                ),
                  SizedBox(height: h * 0.01,),
                  Center(
                    child: Image.asset('assets/images/logo_govindas.png',
                      width: w * 0.7,
                    ),
                  ),
                  SizedBox(height: h * 0.05,),
                  Center(
                    child: Image.asset(
                      'assets/images/delivery_boy.png', // replace with your image URL
                      width: w * 0.78,
                      height: h * 0.33,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),

            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                  child:  Text('Forget Password',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: fontSizes.fontSize24,
                        fontFamily: 'Supreme_bold',
                        fontWeight: FontWeight.w700),
                  ),
                ),



                Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h *0.02),
                  child: Container(
                    height: h * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xFFD0D5DD)
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountryCodePicker(
                          padding: EdgeInsets.zero,
                          initialSelection: 'IN',
                          onChanged: (country){
                            setState(() {
                              selectedCountryCode = country.dialCode!;
                            });
                          },
                        ),
                        SizedBox(
                          width: w * 0.60,

                          child: TextField(
                            controller: mobileController,
                            decoration: InputDecoration(
                                hintText: '00000-00000',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: h * 0.0125),
                                labelStyle: TextStyle(
                                    color: Color(0xFF667085)
                                )
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /*Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h *0.015),
                  child: SizedBox(
                      height: h * 0.05,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD0D5DD),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            labelText: 'OTP',
                            labelStyle: TextStyle(
                                color: Color(0xFF667085)
                            )

                        ),
                      )
                  ),
                ),*/
                Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h *0.015),
                  child: Row(
                    children: [
                      Container(
                        height: h * 0.05,
                        width: w * 0.6,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFD0D5DD),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: otpController,
                            // obscureText: oldPasswordSecure,
                            cursorColor: Color(0xFF001FFF),
                            decoration: InputDecoration(
                              // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              labelText: 'Otp',
                              labelStyle: TextStyle(
                                // Custom style for the label
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060), // Label color
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                              isCollapsed: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                // vertical: screenHeight * 0.005, // Adjust this to control vertical alignment
                                horizontal: w * 0.02,
                              ),
                            ).copyWith(isDense: true),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.02,),
                      GestureDetector(
                        onTap: () async {
                          if(mobileController.text.isNotEmpty || mobileController.text.length >= 10) {
                            setState(() {
                              isLoading = true;
                            });
                            print('PHONE_NUMBER--------->${mobileController
                                .text}');
                            final response = await apiService.forgotPasswordSendOtp(
                                selectedCountryCode + mobileController.text,
                                // mobileTextController.text,
                                AppStrings.RESTAURANT_ID);

                            print('RESPONSE----------: ${response}');

                            if (response.statusCode == 200) {
                              final decodeResponse = jsonDecode(response.body);
                              ErrorPopup.showGlobalPopup(
                                  context: context,
                                  title: 'Success',
                                  titleColor: Colors.green,
                                  message: decodeResponse['message'],
                                  buttonText: 'OK',
                                  buttonTextColor: Colors.black
                              );
                              setState(() {
                                sentOtpBtnText = 'Resend OTP';
                                isLoading = false;
                              });
                            } else {
                              final decodeResponse = jsonDecode(response.body);
                              ErrorPopup.showGlobalPopup(
                                  context: context,
                                  title: 'Error',
                                  titleColor: Colors.red,
                                  message: decodeResponse['message'],
                                  buttonText: 'OK',
                                  buttonTextColor: Colors.black
                              );
                              setState(() {
                                sentOtpBtnText = 'Resend OTP';
                                isLoading = false;
                              });
                            }
                          }else {
                            ErrorPopup.showGlobalPopup(
                                context: context,
                                title: 'Error',
                                titleColor: Colors.red,
                                message: 'Please enter valid mobile number.',
                                buttonText: 'OK',
                                buttonTextColor: Colors.black
                            );
                          }
                        },
                        child: Container(
                          height: h * 0.05,
                          width: w * 0.28,
                          decoration: BoxDecoration(
                            // color: Color(0xFFD0D5DD),
                              color: Color(0xFFF1F1F1),
                              border: Border.all(
                                // color: Color(0xFFF1F1F1),
                                  color: Color(0xFFD0D5DD),
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text(sentOtpBtnText,
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontSize: fontSizes.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF667085)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h *0.015),
                  child: Container(
                    height: h * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFD0D5DD),
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: TextFormField(
                        // obscureText: oldPasswordSecure,
                        controller: newPasswordController,
                        cursorColor: Color(0xFF001FFF),
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          labelText: 'New password',
                          labelStyle: TextStyle(
                            // Custom style for the label
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060), // Label color
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            // vertical: screenHeight * 0.005, // Adjust this to control vertical alignment
                            horizontal: w * 0.02,
                          ),
                        ).copyWith(isDense: true),
                      ),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h *0.015),
                  child: SizedBox(
                    height: h * 0.05,
                    width: w,
                    child: TextButton(
                      onPressed: () {
                        // Action to perform when the button is pressed
                        print('MOBILE NUMBER------------>${mobileController.text}');
                        if(mobileController.text.isEmpty || mobileController.text.length < 10){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter valid mobile number.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                          return;
                        }else if(otpController.text.isEmpty){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter OTP.',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                          return;
                        }if(newPasswordController.text.isEmpty || newPasswordController.text.length < 8){
                          ErrorPopup.showGlobalPopup(
                              context: context,
                              title: 'Error',
                              titleColor: Colors.red,
                              message: 'Please enter 8 character password',
                              buttonText: 'OK',
                              buttonTextColor: Colors.black
                          );
                          return;
                        }else {
                          setState(() {
                            isLoading = true;
                          });
                          apiService.verifyForgotPassword(mobileController.text,
                              otpController.text, newPasswordController.text,
                          AppStrings.RESTAURANT_ID).then((onValue){
                            final response = onValue;
                            if (response.statusCode == 200) {
                              final responseData = jsonDecode(response.body);
                              ErrorPopup.showGlobalPopup(
                                  context: context,
                                  title: 'Success',
                                  titleColor: Colors.green,
                                  message: responseData['message'],
                                  buttonText: 'OK',
                                  buttonTextColor: Colors.black
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }else {

                              final responseData = jsonDecode(response.body);
                              ErrorPopup.showGlobalPopup(
                                  context: context,
                                  title: 'Error',
                                  titleColor: Colors.red,
                                  message: responseData['message'],
                                  buttonText: 'OK',
                                  buttonTextColor: Colors.black
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });



                        }


                        // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferRestaurant()));
                      },
                      child: Text('Continue',
                        style: TextStyle(
                            fontFamily: 'Poppins_semi_bold',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize16,
                            color: Colors.white
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Border radius
                        ),
                        // padding: EdgeInsets.all(16.0), // Padding inside the button
                      ),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: w * 0.04, right: w * 0.05, top: h *0.015),
                  child: SizedBox(
                    height: h * 0.024,
                    width: w,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: (){
                            print('Terms of service and Privacy Policy.');
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize14,
                                color: Color(0xFF001FFF),
                              ),
                            ),
                          ),

                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: h * 0.05,
                      bottom: h * 0.02, left: w * 0.05,
                      right: w * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('powered by Living Menu',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontFamily: 'Poppins_semi_bold',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF606060)
                        ),
                      ),
                      Text('www.livingmenu.in',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontFamily: 'Poppins_semi_bold',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF606060)
                        ),
                      ),
                    ],
                  ),
                )

              ],
            )

          ],


        ),
      ),

    );
  }

}
