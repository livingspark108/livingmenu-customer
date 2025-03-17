import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Reward/congratulation.dart';

import '../Constants/appFontSizes.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards>{
  late double w, h;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
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
                  Text('Rewards',
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
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.02, left: w * 0.05, right: w * 0.05),
                child: ListView.builder(
                    itemCount: 3,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index){
                      return _buildRewardsItem();
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsItem(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Buy 3 Pizzas for ₹20',
                style: TextStyle(
                  fontFamily: 'Poppins_semi_bold',
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizes.fontSize14,
                  color: Colors.black
                ),
              ),
              Text('3/3',
                style: TextStyle(
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: fontSizes.fontSize12,
                    color: Colors.black
                ),
              ),
            ],
          ),
          Container(
            width: w * 0.7,
            child: Text('Buy three pizzas before 21 Nov 2024 to get a reward cash fo ₹20 in your LM Wallet',
              style: TextStyle(
                  fontFamily: 'Poppins_regular',
                  fontWeight: FontWeight.w500,
                  fontSize: fontSizes.fontSize12,
                  color: Color(0xFF606060)
              ),
            ),
          ),
          SizedBox(height: h * 0.02,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Congratulation()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black
              ),
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.012, left: w * 0.05, right: w * 0.05, bottom: h * 0.012),
                child: Text('Redeem',
                  style: TextStyle(
                      fontFamily: 'Poppins_regular',
                      fontWeight: FontWeight.w500,
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
    );
  }

}
