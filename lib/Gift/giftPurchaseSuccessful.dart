import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';

class GiftPurchaseSuccessful extends StatefulWidget {
  const GiftPurchaseSuccessful({Key? key,
    required this.name,
    required this.phone,
    required this.amount,
    required this.code,
  }) : super(key: key);
  final String name;
  final String phone;
  final String amount;
  final String code;

  @override
  State<GiftPurchaseSuccessful> createState() => _GiftPurchaseSuccessfulState();
}

class _GiftPurchaseSuccessfulState extends State<GiftPurchaseSuccessful>{
  late double w, h;
  String? receiversName;
  String? phone;
  String? amount;
  String? code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiversName = widget.name;
    phone = widget.phone;
    amount = widget.amount;
    code = widget.code;
  }

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
                SizedBox(height: h * 0.02,),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ReferRestaurant()));
            },
            child: Container(
              width: w,
              height: h * 0.038,
              color: Color(0xFFFFD7FB),

              child: Padding(
                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/refer_friend.svg'),
                        SizedBox(width: w * 0.02,),
                        Text('Refer a Restaurant',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizes.fontSize12
                          ),
                        ),
                        SizedBox(width: w * 0.01,),
                        Container(
                          height: h * 0.004,
                          width: w * 0.008,
                          color: Colors.black,
                        ),
                        SizedBox(width: w * 0.01,),
                        Text('Get ₹1000',
                          style: TextStyle(
                              fontFamily: 'Poppins_semi_bold',
                              fontWeight: FontWeight.w600,
                              fontSize: fontSizes.fontSize12
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/icons/right_arrow.svg',)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/purchase_successful_bg.png',
                    fit: BoxFit.cover, // Ensures the image covers the available space
                  ),
                ),
                // SizedBox(height: h * 0.2,),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.2),
                  child: Container(
                    width: w,
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/seal_check.svg'),
                        SizedBox(height: h * 0.01,),
                        Text('Purchase Successful',
                          style: TextStyle(
                            fontSize: fontSizes.fontSize24,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Supreme_bold',
                            color: Colors.white,
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 6),
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      color:
                                      Color.fromRGBO(0, 0, 0, 0.3),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/images/gift_card_detail_bg.png',
                                  // fit: BoxFit.cover, // Ensures the image covers the available space
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.04, right: w * 0.06, left: w * 0.06),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('To',
                                        style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize14,
                                          color: Colors.black
                                        ),
                                      ),
                                      Text('₹${amount}',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(receiversName ?? "",
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.black
                                        ),
                                      ),
                                      Text(code ?? '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(phone ?? '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize14,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: h * 0.05,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Clipboard.setData(ClipboardData(text: code ?? '')).then((_) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text("Text copied to clipboard!"),
                                              ),
                                            );
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                            child: Row(
                                              children: [
                                                Text('Copy Code',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins_semi_bold',
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: fontSizes.fontSize12,
                                                      color: Colors.black
                                                  ),
                                                ),
                                                SizedBox(width: w * 0.02,),
                                                SvgPicture.asset('assets/icons/copy_black.svg')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: w * 0.02,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                                          child: Text('Share',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
