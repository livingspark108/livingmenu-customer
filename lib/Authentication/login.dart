import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Authentication/forgotPassword.dart';
import 'package:living_menu_mobile/Authentication/signup.dart';
import 'package:living_menu_mobile/Cart/cart.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Constants/progressIndicator.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../network/apiService.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login>{
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final ApiService apiService = ApiService();
  bool isLoader = false;


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
        enabled: isLoader,
        child: Stack(
          children: [
          Image.asset('assets/images/login_bg.png',
            width: screenWidth,
            fit: BoxFit.fill,
          ),

           /* Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.048),
              child: Image.asset('assets/images/login_bg.png',
                width: screenWidth,
                fit: BoxFit.fill,
              ),
            ),*/
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child:  Center(
                    child: Image.asset(
                      'assets/images/delivery_boy.png', // replace with your image URL
                      width: screenWidth * 0.78,
                      height: screenHeight * 0.33,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
                      child:  Text('Sign In',
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
                            ),
                            SizedBox(
                              width: screenWidth * 0.60,

                              child: TextField(
                                controller: mobileTextController,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
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
                            // obscureText: oldPasswordSecure,
                            controller: passwordTextController,
                            obscureText: true,
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

                    /*Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),
                      child: SizedBox(
                          height: screenHeight * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFD0D5DD),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Color(0xFF667085)
                                )

                            ),
                          )
                      ),
                    ),*/

                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.005),
                      child: SizedBox(
                        height: screenHeight * 0.04,
                        width: screenWidth,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPassword()));
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Forgot your Password?',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001FFF),
                                  fontSize: fontSizes.fontSize12
                              ),),
                          ),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
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
                            /*final mobileNum = mobileTextController.text;
                            if(mobileNum.isEmpty){

                            }*/


                            setState(() {
                              isLoader = true;
                            });
                            final response = await apiService.login(
                                username: '7410912340',
                                password: '87654321',
                                device_id: 'mobile-1',
                                fcm_token: 'ssdfsdfsdfsdfsdfsdf');

                            // print('RESPONSE: ${response}');
                            // print('STATUS: ${response['status']}');
                            // print('USER_ID: ${response['data']['id']}');

                            if (response['status'] == 'success'){
                              print('LOGIN--------------->>>>${response}');

                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('userId', response['data']['id']);
                              await prefs.setString('firstName', response['data']['first_name']);
                              await prefs.setString('lastName', response['data']['last_name']);
                              await prefs.setString('mobileNumber', response['data']['username']);
                              await prefs.setString('userEmail', response['data']['email']);
                              await prefs.setString('authToken', response['data']['token']);
                              await prefs.setBool('isLogin', true);

                              // final storage = FlutterSecureStorage();
                              // await storage.write(key: "auth_token", value: response['data']['token']);
                              //
                              // final token = await storage.read(key: "auth_token");
                              // print("Retrieved token: $token");
                              // print('FIRST_NAME: ${prefs.getString('firstName')}');
                              Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(MainScreen()), (route) => false);
                              setState(() {
                                isLoader = false;
                              });
                            }

                          },
                          child: Text('Sign In',
                            style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizes.fontSize16
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

                    Padding(padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight *0.015),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Signup()));
                        },
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFF001FFF),
                              width: 1
                            )
                          ),
                          child: Center(
                            child: Text('Create New Account',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                color: Color(0xFF001FFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.05,
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
          ],
        ),
      ),

    );
  }
}