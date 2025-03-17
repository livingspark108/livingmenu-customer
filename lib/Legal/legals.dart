import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class Legals extends StatefulWidget {
  const Legals({super.key});

  @override
  State<Legals> createState() => _LegalsState();
}

class _LegalsState extends State<Legals>{
  late double w, h;
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
                Text('Legals',
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
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Terms & Conditions',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset('assets/icons/arrow_insert.svg'),
                  ],
                ),
                SizedBox(height: h * 0.02,),
                Container(
                  width: w,
                  height: h * 0.001,
                  color: Color(0xFFF1F1F1),
                ),

                SizedBox(height: h * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping Policy',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset('assets/icons/arrow_insert.svg'),
                  ],
                ),
                SizedBox(height: h * 0.02,),
                Container(
                  width: w,
                  height: h * 0.001,
                  color: Color(0xFFF1F1F1),
                ),

                SizedBox(height: h * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Privacy Policy',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset('assets/icons/arrow_insert.svg'),
                  ],
                ),
                SizedBox(height: h * 0.02,),
                Container(
                  width: w,
                  height: h * 0.001,
                  color: Color(0xFFF1F1F1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
