import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Gift/giftCard.dart';
import 'package:living_menu_mobile/Reward/referRestaurant.dart';
import 'package:living_menu_mobile/Wallet/addFund.dart';
import 'package:living_menu_mobile/Wallet/walletTransaction.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Delivery/deliveryTime.dart';
import '../Models/walletTransectionModel.dart';

class LivingMenuWallet extends StatefulWidget {
  const LivingMenuWallet({Key? key}) : super(key: key);

  @override
  State<LivingMenuWallet> createState() => _LivingMenuWalletState();
}

class _LivingMenuWalletState extends State<LivingMenuWallet>{
  late double w, h;
  ApiService apiService = ApiService();
  WalletTransactions walletTransactions = WalletTransactions();
  bool isLoading = false;
  int? walletBalance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
    });

    apiService.getWalletTransaction(context).then((value) {
      setState(() {
        walletTransactions = value;
        // walletBalance = walletTransaction.walletBalance;
        print('Wallet Transection--------------------->>> ${walletTransactions}');

        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Container(
          child: Column(
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
                    Text('Living Menu Wallet',
                      style: TextStyle(
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          fontSize: fontSizes.fontSize24
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.015,),
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
                            Text('Refer Restaurant',
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

              Padding(
                padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, right: w * 0.04),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/Wallet_Bal_bg.png',
                        )
                    ),
                    Container(
                      width: w,
                      decoration: BoxDecoration(
                          // color: Color(0xFF001FFF),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, right: w * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Your Balance',
                                  style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.75)
                                  ),
                                ),
                                SvgPicture.asset('assets/icons/question_mark_rounded.svg')
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/wallet_small_white.svg'),
                                SizedBox(width: w * 0.02,),
                                Text('${walletTransactions.walletBalance.toString()} INR',
                                  style: TextStyle(
                                      fontFamily: 'Supreme_bold',
                                      fontSize: fontSizes.fontSize24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child:  Padding(
                          padding: EdgeInsets.only(right: w * 0.04, bottom: h * 0.02),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(GiftCard()));
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.007, bottom: h * 0.007),
                                    child: Text('Redeem Gift Card',
                                      style: TextStyle(
                                          fontFamily: 'Supreme_bold',
                                          fontSize: fontSizes.fontSize14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AddFund()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.007, bottom: h * 0.007),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/add_black.svg'),
                                        SizedBox(width: w * 0.02,),
                                        Text('Add Funds',
                                          style: TextStyle(
                                              fontFamily: 'Supreme_bold',
                                              fontSize: fontSizes.fontSize14,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Transactions',
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(WalletTransaction(allTransactions: walletTransactions.allTransactions ?? [])));
                      },
                        child: SvgPicture.asset('assets/icons/arrow_right_grey_bg.svg')
                    )
                  ],
                ),
              ),
              SizedBox(height: h * 0.02,),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: walletTransactions.recentTransactions?.length ?? 0,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index){
                      Transaction transaction = walletTransactions.recentTransactions![index];
                        return _buildTransactionItem(transaction);
                      }
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction){
    AppFontSizes fontSizes = AppFontSizes(context);
    String? purchaseDate = transaction.date;
    String? formattedDate;
    double? amount = transaction.amount;
    bool type = false;
    if(transaction.type == "credit"){
      type = true;
    }else {
      type = false;
    }
    if(purchaseDate != null) {
      DateTime dateTime = DateTime.parse(purchaseDate);
      // Format the date to "19/12/23"
      formattedDate = DateFormat("dd/MM/yy (HH:mm)").format(dateTime);
      // Format the time to "15:36"
      // formattedTime = DateFormat("HH:mm").format(dateTime);
    }else {
      formattedDate = 'No Date';
      // formattedTime = 'No Time';
    }
    return Container(
      child: Column(
        children: [
          SizedBox(height: h * 0.02,),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction.transactionId ?? '',
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    Text(formattedDate,
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF606060)
                      ),
                    ),
                  ],
                ),
                Text(type ? '+${amount.toString()}' : '-${amount.toString()}',
                  style: TextStyle(
                      fontFamily: 'Poppins_regular',
                      fontSize: fontSizes.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: type ? Color(0xFF001FFF) : Colors.black
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.02,),
          Container(
            height: h * 0.001,
            width: w,
            color: Color(0xFFF1F1F1),
          )
        ],
      ),
    );
  }

}
