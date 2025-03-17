import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/CustomItems/errorPopup.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../network/networkChecker.dart';
import 'login.dart';

class Signup extends StatefulWidget{
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup>{
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final ApiService apiService = ApiService();
  String sentOtpBtnText = 'Send OTP';
  String selectedCountryCode = '+91';
  bool isLoading = false;

  Future<void> setDineIn () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDineIn', false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDineIn();
  }

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Center(
                child: Image.asset('assets/images/logo_govindas.png',
                  width: screenWidth * 0.8,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
                  child:  Text('Create New Account',
                    style: TextStyle(
                        color: Color(0xFF001FFF),
                        fontSize: fontSizes.fontSize24,
                        fontFamily: 'Supreme_bold',
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.02),
                  child: Container(
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFD0D5DD),
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: nameTextController,
                        // obscureText: oldPasswordSecure,
                        cursorColor: Color(0xFF001FFF),
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          labelText: 'Name',
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
                            horizontal: screenWidth * 0.02,
                          ),
                        ).copyWith(isDense: true),
                      ),
                    ),
                  ),
                ),


                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),


                  child: Container(
                    height: screenHeight * 0.05,
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
                          onChanged: (country){
                            setState(() {
                              selectedCountryCode = country.dialCode!;
                            });
                          },
                          padding: EdgeInsets.zero,
                          initialSelection: 'IN',
                        ),
                        SizedBox(
                          width: screenWidth * 0.60,

                          child: TextField(
                            controller: mobileTextController,
                            decoration: InputDecoration(
                                hintText: '00000-00000',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.0125),
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

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),
                  child: Row(
                    children: [
                      Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.6,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFD0D5DD),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: otpTextController,
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
                                horizontal: screenWidth * 0.02,
                              ),
                            ).copyWith(isDense: true),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02,),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          print('PHONE_NUMBER--------->${mobileTextController.text}');
                          final response = await apiService.sendOtp(
                              selectedCountryCode + mobileTextController.text,
                              // mobileTextController.text,
                              AppStrings.RESTAURANT_ID);

                          print('RESPONSE----------: ${response}');

                          if(response.statusCode == 200){
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
                          }else {
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
                        },
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.28,
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

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),
                  child: Container(
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFFD0D5DD),
                            width: 1
                        ),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: passwordTextController,
                        // obscureText: oldPasswordSecure,
                        cursorColor: Color(0xFF001FFF),
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          labelText: 'Password',
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
                            horizontal: screenWidth * 0.02,
                          ),
                        ).copyWith(isDense: true),
                      ),
                    ),
                  ),
                ),



                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),
                  child: SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth,
                    child: TextButton(
                      onPressed: () async {
                        // bool isInternet = await NetworkChecker.isInternetAvailable();
                        // if(isInternet) {
                          setState(() {
                            isLoading = true;
                          });
                          // Action to perform when the button is pressed
                          final response = await apiService.verifyOtp(
                              selectedCountryCode + mobileTextController.text,
                              otpTextController.text,
                              passwordTextController.text,
                              nameTextController.text
                          );
                          if (response.statusCode == 201) {
                            final decodeResponse = jsonDecode(response.body);
                            print(
                                'SIGN_UP_RESPONSE---------> ${response.body}');
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('userId', decodeResponse['data']['id']);
                            await prefs.setString('firstName', decodeResponse['data']['first_name']);
                            await prefs.setString('lastName', decodeResponse['data']['last_name']);
                            await prefs.setString('mobileNumber', decodeResponse['data']['username']);
                            await prefs.setString('userEmail', decodeResponse['data']['email']);
                            await prefs.setString('authToken', decodeResponse['data']['token']);
                            await prefs.setBool('isLogin', true);
                            print(prefs.getString('firstName'));
                            // final decodeResponse = jsonDecode(response.body);
                            ErrorPopup.showGlobalPopup(
                                context: context,
                                title: 'Success',
                                titleColor: Colors.green,
                                message: decodeResponse['message'],
                                buttonText: 'OK',
                                buttonTextColor: Colors.black
                            );
                            setState(() {
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
                              isLoading = false;
                            });
                          }
                        // }else {
                        //   ErrorPopup.showGlobalPopup(
                        //       context: context,
                        //       title: 'Error',
                        //       titleColor: Colors.red,
                        //       message: 'Please check your internet connection',
                        //       buttonText: 'OK',
                        //       buttonTextColor: Colors.black
                        //   );
                        // }


                        // Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(MainScreen()), (route) => false);
                      },
                      child: Text('Agree & continue',
                        style: TextStyle(
                          fontFamily: 'Poppins_semi_bold',
                          fontWeight: FontWeight.w600,
                          fontSize: fontSizes.fontSize16,
                          color: Colors.white
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF001FFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Border radius
                        ),
                        // padding: EdgeInsets.all(16.0), // Padding inside the button
                      ),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.01),
                  child: SizedBox(
                    height: screenHeight * 0.024,
                    width: screenWidth,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("By selecting Agree and continue above,",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              color: Color(0xFF606060)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.00),
                  child: SizedBox(
                    height: screenHeight * 0.024,
                    width: screenWidth,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("I agree to ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              color: Color(0xFF606060)
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            print('Terms of service and Privacy Policy.');
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Terms of service and Privacy Policy.',
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

                Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.01, bottom: screenHeight * 0.02),
                  child: SizedBox(
                    height: screenHeight * 0.03,
                    width: screenWidth,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize14,
                              color: Color(0xFF606060)
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            print('Terms of service and Privacy Policy.');

                           /* setState(() {
                              isLoader = true;
                            });*/
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
                  padding: EdgeInsets.only(top: screenHeight * 0.01,
                      bottom: screenHeight * 0.02, left: screenWidth * 0.05,
                      right: screenWidth * 0.05),
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