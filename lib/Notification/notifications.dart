import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Orders/orderHistory.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>{
  late double w,h;
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
                Text('Notification',
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
          // SizedBox(height: h * 0.02,),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
                padding: EdgeInsets.zero,
                itemBuilder: (contaxt, index){
                  return _buildItem(index);
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index){
    AppFontSizes fontSizes = AppFontSizes(context);
    if(index == 0) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.014,
                            width: w * 0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF001FFF)
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order #ILBFFIKJAB Delivered',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                    height: 1
                                ),
                              ),
                              Text('Thank you for your order.',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Today',
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060),
                                height: 1
                            ),
                          ),
                          Text('12:42',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF606060),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01,),
                  Row(
                    children: [
                      SizedBox(width: w * 0.05,),
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPasswordAS()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                            child: Text('Order Again',
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
                              Navigator.push(context, AnimatedRoute.createRouteRightToLeft(OrderHistory()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // color: Color(0xFF001FFF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                                child: Text('Give Feedback',
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
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02,),
            Container(
              width: w,
              height: h * 0.001,
              color: Color(0xFFF1F1F1),
            ),
          ],
        ),
      );
    }else if(index == 1){
      return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.014,
                            width: w * 0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFFA4A0C)
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pending Payment',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                    height: 1
                                ),
                              ),
                              Text('Pay ₹320 here',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Today',
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060),
                                height: 1
                            ),
                          ),
                          Text('12:42',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF606060),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: h * 0.01,),
                  Row(
                    children: [
                      SizedBox(width: w * 0.05,),
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPasswordAS()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                            child: Text('Pay Now',
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
            ),
            SizedBox(height: h * 0.02,),
            Container(
              width: w,
              height: h * 0.001,
              color: Color(0xFFF1F1F1),
            ),
          ],
        ),
      );
    }else {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h * 0.014,
                            width: w * 0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF2DBFE0),
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ready for pickup',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black,
                                    height: 1
                                ),
                              ),
                              Text('Arrives between 11:51 PM-12:01 AM',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Today',
                            style: TextStyle(
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_regular',
                                color: Color(0xFF606060),
                                height: 1
                            ),
                          ),
                          Text('12:42',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF606060),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: h * 0.02,),
            Container(
              width: w,
              height: h * 0.001,
              color: Color(0xFFF1F1F1),
            ),
          ],
        ),
      );
    }
  }

}
