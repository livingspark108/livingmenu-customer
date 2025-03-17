import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/GradientText.dart';

import '../Constants/appFontSizes.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  late double w, h;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFA14DAA),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/coming_soon_bg.png',
                  width: w,
                  height: h,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: h * 0.385,
                  left: w * 0.17,
                  child: Column(
                    children: [
                      GradientText(
                        "Coming",
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF8E0A5),
                            Color(0xFFEBA856),
                          ],
                        ),
                        // fontSize: 60,
                        fontSize: fontSizes.fontSize60,
                        fontFamily: 'Archivo_bold',
                        height: 1,
                      ),
                      GradientText(
                        "Soon",
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFF8E0A5),
                            Color(0xFFEBA856),
                          ],
                        ),
                        // fontSize: 10,
                        fontSize: fontSizes.fontSize60,
                        fontFamily: 'Archivo_bold',
                        height: 0.8,
                      ),
                      SizedBox(height: h * 0.025,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                            child: Text('Explore App',
                              style: TextStyle(
                                fontSize: fontSizes.fontSize16,
                                fontFamily: 'Poppins_bold',
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
