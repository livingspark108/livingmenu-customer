import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Authentication/login.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Home/homeScreen.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/circular_indicator.dart';
import '../Home/mainScreenNew.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late double h, w;
  bool isloader = false;
  String? restaurantLogo;
  String? message;
  ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isloader = true;
    });
    apiService.getStarted(context).then((onValue){
      final response = onValue;
      final data = jsonDecode(response.body);
      restaurantLogo = data['restaurant_logo'];
      message = data['message'];

      setState(() {
        isloader = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    return Scaffold(
      body: Skeletonizer(
        enabled: isloader,
        child: Stack(
          children: [
            Image.asset('assets/images/splash_bg.png'),
            Container(
              height: h * 1,
              width: w * 1,
              /*decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD1C3FF),
                    Color.fromRGBO(209, 195, 255, 0.0),
                  ],
                ),
              ),*/
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.1),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_govindas.png',
                      width: w * 0.8,
                      height: h * 0.1,
                    ),
                    // Image.network(ApiService.imageBaseUrl + restaurantLogo!),
                    SizedBox(
                      height: h * 0.06,
                    ),
                    Container(
                      // width: w * 0.9,
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: w * 0.8,
                              child: Text(
                                // 'Parasdam on the way',
                                message?? '',
                                style: TextStyle(
                                    color: Color(0xFF001FFF),
                                    // fontSize: 65,
                                    fontSize: fontSizes.fontSize36,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins_semi_bold',
                                    height: 0.9
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          /*Text(
                            'on the way',
                            style: TextStyle(
                                color: Color(0xFF001FFF),
                                // fontSize: 65,
                                fontSize: fontSizes.fontSize36,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins_semi_bold',
                                height: 0.9
                            ),
                            textAlign: TextAlign.center,
                          ),*/
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Image.asset(
                      'assets/images/delivery_boy.png', // replace with your image URL
                      width: w * 0.9,
                      height: h * 0.4,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: h * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                      child: GestureDetector(
                        onTap: (){
                          // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Login()));
                          Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(Login()), (route) => false);
                        },
                        child: Container(
                          width: w,
                          height: h * 0.06,
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                            child: Text('Get Started',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize16,
                                fontFamily: 'Poppins_semi_bold',
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    /*MaterialButton(
                      height: h * 0.07,
                      minWidth: w * 0.75,
                      onPressed: () {
                        setState(() {
                          isloader = true;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        ).then((value) {
                          setState(() {
                            isloader = false;
                          });
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Set the border radius as per your requirement
                      ),
                      color: const Color(0xFF634FA1),
                      child: isloader
                          ? circularIndicator()
                          : Text(
                        'Get Started',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizes.fontSize17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins_semi_bold' // Text color
                        ),
                      ),
                    ),*/
                    // Add other widgets or content here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
