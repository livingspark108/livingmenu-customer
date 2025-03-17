import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Gift/buyGiftCard.dart';
import 'package:living_menu_mobile/Models/giftCardListModel.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/appFontSizes.dart';
import '../CustomItems/errorPopup.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({super.key});

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard>{
  late double w,h;
  bool isLoading = false;
  ApiService apiService = ApiService();
  List<CardList>? cardList;
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });

    apiService.getGiftCards(context).then((value){
      setState(() {
        cardList = value;
        isLoading = false;
        print('GIFT_CARD-------> ${cardList}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.07, left: w * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/icons/header_back.svg')
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, AnimatedRoute.createRouteRightToLeft(BuyGiftCard()));
                            },
                            child: Container(
                              width: w * 0.35,
                              // height: h * 0.1,
                              child: Text('Buy a Gift Card',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: Color(0xFF001FFF),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: h * 0.03,),
                      Text('Gift Card',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gift Card Number',
                        style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins_regular',
                          color: Color(0xFF606060),
                        ),
                      ),
                      SizedBox(height: h * 0.01,),
                      Container(
                        height: h * 0.05,
                        width: w,
                        alignment: Alignment.center,
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFF1F1F1),
                          // color: Colors.red,
                        ),
                        child: TextFormField(
                          cursorColor: Colors.red,
                          controller: codeController,
                          decoration: InputDecoration(
                            // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            hintText: 'Enter Gift Card Code',
                            labelText: 'Enter Gift Card Code',
                            labelStyle: TextStyle(
                              // Custom style for the label
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFF606060), // Label color
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F1F1),
                            isCollapsed: true,
                            border: InputBorder.none,
                          ).copyWith(isDense: true),
                        ),
                      ),
                      SizedBox(height: h * 0.03,),
                      /*Text('Available Gift Cards',
                        style: TextStyle(
                          fontSize: fontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins_regular',
                          color: Colors.black,
                        ),
                      ),*/
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                    child: ListView.builder(
                        itemCount: cardList?.length ?? 0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (contaxt, index){
                          final card = cardList![index];
                          return Column(
                            children: [
                              _buildItem(card),
                              SizedBox(height: h * 0.015,),
                            ],
                          );

                        }
                    ),
                  ),
                ),
                SizedBox(height: h * 0.1,),
              ],
            ),
            Positioned(
              bottom: 0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        height: h * 0.001,
                        color: Color(0xFFF1F1F1),
                      ),

                      SizedBox(height: h * 0.02,),

                      GestureDetector(
                        onTap: (){
                          if(codeController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter gift card code'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else {
                            setState(() {
                              isLoading = true;
                            });
                            apiService.giftCarsRedeem(
                                context, codeController.text).then((onValue) {
                              final response = onValue;
                              final data = jsonDecode(response.body);
                              ErrorPopup.showGlobalPopup(
                                  context: context,
                                  title: 'Success',
                                  titleColor: Colors.green,
                                  message: data['message'],
                                  buttonText: 'OK',
                                  buttonTextColor: Colors.black
                              );
                              setState(() {
                                isLoading = false;
                              });
                            });
                          }

                        },
                        child: Container(
                          width: w * 0.9,
                          height: h * 0.06,
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text('Redeem',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.02,),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(CardList card){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      width: w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFF1F1F1)
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('₹ ${card.amount}',
                  style: TextStyle(
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: fontSizes.fontSize14,
                    color: Colors.black
                  ),
                ),
                Text('Expires Today',
                  style: TextStyle(
                      fontFamily: 'Poppins_regular',
                      fontWeight: FontWeight.w500,
                      fontSize: fontSizes.fontSize12,
                      // color: Color(0xFF939393)
                      color: Color(0xFFB3261E)
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Clipboard.setData(ClipboardData(text: card.code ?? '')).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Text copied to clipboard!"),
                    ),
                  );
                });
              },
              child: Row(
                children: [
                  Text(card.code ?? '',
                    style: TextStyle(
                        fontFamily: 'Poppins_regular',
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizes.fontSize12,
                        color: Color(0xFF606060)
                    ),
                  ),
                  SizedBox(width: w * 0.02,),
                  SvgPicture.asset('assets/icons/copy.svg')

                ],
              ),
            ),

            SizedBox(height: h * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPasswordAS()));
                  },
                  child: Container(
                    /*decoration: BoxDecoration(
                      // color: Color(0xFF001FFF),
                      // borderRadius: BorderRadius.circular(8),
                    ),*/
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                      child: Text('Share',
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

                SizedBox(width: w * 0.02,),

                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ForgotPasswordAS()));
                    if(card.isRedeemed ?? false){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Already redeemed.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }else {
                      setState(() {
                        isLoading = true;
                      });
                      apiService.giftCarsRedeem(context, card.code ?? '').then((onValue){
                        final response = onValue;
                        final data = jsonDecode(response.body);
                        ErrorPopup.showGlobalPopup(
                            context: context,
                            title: 'Success',
                            titleColor: Colors.green,
                            message: data['message'],
                            buttonText: 'OK',
                            buttonTextColor: Colors.black
                        );
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8),
                        /*border: Border.all(
                            color: Colors.black,
                            width: 1
                        )*/
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.012, bottom: h * 0.012),
                      child: Text(card.isRedeemed ?? false ? 'Redeemed' : 'Redeem',
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
            SizedBox(height: h * 0.015,),
          ],
        ),
      ),
    );
  }

}
