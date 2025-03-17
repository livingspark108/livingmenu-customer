import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PromoCodeRewards extends StatefulWidget {
  const PromoCodeRewards({Key? key}) : super(key: key);

  @override
  State<PromoCodeRewards>  createState() => _PromoCodeRewardsState();
}

class _PromoCodeRewardsState extends State<PromoCodeRewards>{
  late double w, h;
  bool isEnterPromoEnabled = false;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: w,
        height: h,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: SvgPicture.asset('assets/icons/header_back.svg'),
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Text('Promo codes, rewards & gift cards',
                            style: TextStyle(
                                fontFamily: 'Supreme_bold',
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize24
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      constraints: BoxConstraints(
                        maxHeight: h * 0.82, // Adjust this value based on your layout needs
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Add Promo Code',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize16,
                                          fontFamily: 'Poppins_semi_bold'
                                      ),
                                    ),

                                    SizedBox(height:  h * 0.025,),
                                    Stack(
                                      children: [
                                        Container(
                                          height: h * 0.06,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xFFF9F9F9),
                                            // color: Colors.red,
                                          ),
                                          child: TextFormField(
                                            cursorColor: Colors.red,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              labelText: 'Enter Promo Code',
                                              labelStyle: TextStyle(   // Custom style for the label
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060), // Label color
                                              ),
                                              hintText: 'Enter Promo Code',
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060),  // Hint text color
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFF9F9F9),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ).copyWith(isDense: true),
                                          ),
                                        ),

                                        Positioned(
                                          right: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: h * 0.012, bottom: h * 0.02, right: w * 0.03),
                                            child: Container(
                                              child: Text('Apply',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins_semi_bold',
                                                    fontSize: fontSizes.fontSize16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF939393)
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(height: h * 0.025,),
                              Container(
                                height: h * 0.001,
                                width: w,
                                color: Color(0xFFF1F1F1),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: h * 0.02,),

                                    Text('Redeem your gift card',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize16,
                                          fontFamily: 'Poppins_semi_bold'
                                      ),
                                    ),

                                    SizedBox(height:  h * 0.025,),

                                    Stack(
                                      children: [
                                        Container(
                                          height: h * 0.06,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: w * 0.11, bottom: h * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xFFF9F9F9),
                                            // color: Colors.red,
                                          ),
                                          child: TextFormField(
                                            cursorColor: Colors.red,
                                            decoration: InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              labelText: 'Enter Gift Card PIN',
                                              labelStyle: TextStyle(   // Custom style for the label
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060), // Label color
                                              ),
                                              hintText: 'Enter Gift Card PIN',
                                              hintStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060),  // Hint text color
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFF9F9F9),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ).copyWith(isDense: true),
                                          ),
                                        ),

                                        Positioned(
                                            top: h * 0.016,
                                            left: w * 0.03,
                                            child: SvgPicture.asset('assets/icons/redeem_gift_icon.svg')
                                        ),

                                        Positioned(
                                          right: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: h * 0.012, bottom: h * 0.02, right: w * 0.03),
                                            child: Container(
                                              child: Text('Redeem',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins_semi_bold',
                                                    fontSize: fontSizes.fontSize16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF939393)
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: h * 0.025,),
                              Container(
                                height: h * 0.001,
                                width: w,
                                color: Color(0xFFF1F1F1),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Available Rewards & Promotions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize16,
                                          fontFamily: 'Poppins_semi_bold'
                                      ),
                                    ),

                                    SizedBox(height:  h * 0.025,),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index){
                                          return Column(
                                            children: [
                                              _buildRewardsItem(),
                                              SizedBox(height: h * 0.015,)
                                            ],
                                          );
                                        }
                                    ),



                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsItem(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.143,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFF1F1F1),
          width: w * 0.004
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.015),
            child: Text('₹50 off ₹200+',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSizes.fontSize14,
                fontFamily: 'Poppins_semi_bold',
                color: Colors.black
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.005),
            child: Text('₹50 off on orders ₹200+ with code #7E5OFF20',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSizes.fontSize12,
                  fontFamily: 'Poppins_semi_bold',
                  color: Color(0xFF606060)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.018, right: w * 0.04),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, top: h * 0.01, bottom: h * 0.012, right: w * 0.04),
                  child: Text('Apply',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Poppins_semi_bold',
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
