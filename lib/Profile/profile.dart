import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Models/savedProductModel.dart';
import 'package:living_menu_mobile/Orders/myOrders.dart';
import 'package:living_menu_mobile/Profile/accountSettings.dart';
import 'package:living_menu_mobile/Settings/settings.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../ComingSoon/comingSoon.dart';
import '../Constants/GradientText.dart';
import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  late double h, w;
  bool isSavedItemAvailable = false;
  ApiService apiService = ApiService();
  List<SavedProductModel>? productModel;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
      // isSavedItemAvailable = true;
    });

    apiService.getSavedProduct(context).then((value) {
      setState(() {
        productModel = value;
        print('Saved Items---------------: ${value}');
        print('Saved Items---------------: ${productModel![0].product}');


        if(productModel != null && productModel!.length > 0){
          isSavedItemAvailable = true;
          _isLoading = false;
        }


      });

    });
  }

  @override
  Widget build (BuildContext context){
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.05, left: w * 0.03, right: w * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/work_icon.svg',
                          width: w * 0.04,
                        ),
                        SizedBox(width: w * 0.015,),
                        Text('Work',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins_regular',
                            fontSize: fontSizes.fontSize14,
                          ),
                        ),
                        SizedBox(width: w * 0.015,),
                        SvgPicture.asset(
                          'assets/icons/down_arrow_black.svg',
                          width: w * 0.04,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/notification_icon.svg',
                          width: w * 0.08,
                        ),
                        SizedBox(width: w * 0.025,),
                        SvgPicture.asset(
                          'assets/icons/cart_bag_icon.svg',
                          width: w * 0.06,
                        ),
                        SizedBox(width: w * 0.03,),
                        Container(
                          height: h * 0.029,
                          width: w * 0.062,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF001FFF), Color(0xFF001FFF)], // Set your gradient colors
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25), // Adjust the border radius
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25), // Ensure the same radius is applied to the image
                                  child: Image.asset(
                                    'assets/images/profile_img.png',
                                    height: h * 0.027,
                                    width: w * 0.058,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: h * 0.1,
                      width: w * 0.18,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF8E0A5), Color(0xFFEBA856)], // Set your gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8), // Adjust the border radius
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8), // Ensure the same radius is applied to the image
                              child: Image.asset(
                                'assets/images/profile_img.png',
                                height: h * 0.098,
                                width: w * 0.177,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: h * 0.005),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/icons/Prime_enable.png',
                                    width: w * 0.03,
                                  ),
                                  SizedBox(height: h * 0.003,),
                                  GradientText(
                                    "Prime User",
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFF8E0A5),
                                        Color(0xFFEA9A38),
                                      ],
                                    ),
                                    // fontSize: 10,
                                    fontSize: fontSizes.fontSize10,
                                    fontFamily: 'Poppins_bold',
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Wade Warren',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Supreme_bold',
                                  fontSize: fontSizes.fontSize24,
                                  height: 1.2
                              ),
                            ),
                            Text('Living Menu customer since Nov’23',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins_medium',
                                fontSize: fontSizes.fontSize10,
                              ),
                            ),
                            SizedBox(height: h * 0.005,),
                            Container(
                              width: double.infinity,
                              child: Text('Try Living Menu Prime to get ₹0 deliverry fees and reduced service fees.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_medium',
                                  fontSize: fontSizes.fontSize10,
                                  color: Color(0xFF7B7B7B),
                                  // height: 1
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AccountSettings()));
                      },
                      child: Container(
                        height: h * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF1F1F1)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/edit_profile.svg',
                                width: w * 0.05,
                              ),
                              SizedBox(width: w * 0.012),
                              Text('Edit Profile',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_bold'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: w * 0.015,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(ComingSoon()));
                      },
                      child: Container(
                        height: h * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF1F1F1)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Row(
                            children: [
                              Image.asset('assets/icons/prime_disable.png',
                                width: w * 0.045,
                              ),
                              SizedBox(width: w * 0.012),
                              Text('Try Prime',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_bold'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: w * 0.015,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Myorders()));
                      },
                      child: Container(
                        height: h * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF1F1F1)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Row(
                            children: [
                              /*Image.asset('assets/receipt.png',
                                width: w * 0.045,
                              ),*/
                              SvgPicture.asset('assets/icons/order_receipt.svg',
                                width: w * 0.045,
                              ),
                              SizedBox(width: w * 0.012),
                              Text('Orders',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_bold'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: w * 0.015,),
                    GestureDetector(
                      onTap: (){
                        // How to show bottom navigation bar on settings screen
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Settings()));
                      },
                      child: Container(
                        height: h * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF1F1F1)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Row(
                            children: [
                              /*Image.asset('assets/settings.png',
                                width: w * 0.045,
                              ),*/
                              SvgPicture.asset('assets/icons/settings.svg',
                                width: w * 0.045,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.015,),
              Container(
                width: w,
                height: h * 0.038,
                color: Color(0xFFEEE3FF),

                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Delivery Status',
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
                          Text('Arriving in 30 mins',
                            style: TextStyle(
                                fontFamily: 'Poppins_semi_bold',
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize12
                            ),
                          ),
                        ],
                      ),
                      /*Image.asset('assets/icons/right_arrow.png',
                        height: h * 0.015,
                      ),*/
                      SvgPicture.asset('assets/icons/right_arrow.svg',
                        height: h * 0.015,
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.015, left: w * 0.03),
                  child: Text('Saved Items',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Supreme_bold'
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: isSavedItemAvailable,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.015),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: productModel?.length ?? 0,
                      itemBuilder: (context, index) {
                        Product? product = productModel![index].product;
                        return Column(
                          children: [

                            // Product? productM = productModel[index].product;

                            _buildItems(context, product),
                            SizedBox(height: h * 0.02)
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isSavedItemAvailable,
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(height: h * 0.03,),
                              SvgPicture.asset('assets/icons/no_item_found.svg'),
                              SizedBox(height: h * 0.03,),
                              Text('You don’t have any saved items',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins_regular'
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.02,),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/bookmark_black.svg'),
                            SizedBox(width: w * 0.04,),
                            Expanded(
                              child: Text(AppStrings.NO_SAVED_ITEM_MSG1,
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.02,),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/user_black.svg'),
                            SizedBox(width: w * 0.04,),
                            Expanded(
                              child: Text(AppStrings.NO_SAVED_ITEM_MSG2,
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.04,),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                              child: Text('Browse items',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_regular',
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildItems(BuildContext context, Product? product){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.144,
      width: w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: Color(0xFFF1F1F1),
              width: 1
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.015, left: w * 0.05, right: w * 0.05),
            child: Container(
              width: w * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product!.title ?? '',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_bold'
                    ),
                  ),
                  Text('₹${product!.price.toString() ?? ''}',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                      color: Colors.black
                    ),
                  ),
                  Container(
                    height: h * 0.038,
                    child: Text(product!.shortDescription ?? '',
                      style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins_regular',
                          color: Color(0xFF606060)
                        // height: 1
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: h * 0.012,),
                  Row(
                    children: [
                      /*Image.asset('assets/Veg_icon.png',
                        width: w * 0.03,
                      ),*/
                      SvgPicture.asset('assets/icons/veg_icon.svg',
                        width: w * 0.03,
                      ),
                      SizedBox(width: w * 0.01,),
                      Text('4.3',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                      SizedBox(width: w * 0.01,),
                      /*Image.asset('assets/star_new.png',
                        width: w * 0.03,
                      ),*/
                      SvgPicture.asset('assets/icons/Star.svg',
                        width: w * 0.03,
                      ),
                      SizedBox(width: w * 0.01,),
                      Text('(30K+)',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                      SizedBox(width: w * 0.01,),
                      Container(
                        height: h * 0.004,
                        width: w * 0.008,
                        color: Colors.black,
                      ),
                      SizedBox(width: w * 0.01,),
                      /*Image.asset('assets/watch_new.png',
                        width: w * 0.03,
                      ),*/
                      SvgPicture.asset('assets/icons/time_icon.svg',
                        width: w * 0.03,
                      ),
                      // SizedBox(width: w * 0.01,),
                      Text('28 min',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ), // Ensure the same radius is applied to the image
                child: Image.asset(
                  'assets/images/cheese_pizza_profile.png',
                  height: h * 0.138,
                  width: w * 0.29,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0, // Align to the top
                right: 0, // Align to the right
                child: Padding(
                  padding: EdgeInsets.only(right: w * 0.01, top: h * 0.008), // Add padding if you want some space from the edge
                  child: SvgPicture.asset(
                    'assets/icons/favourite_icon.svg',
                    width: w * 0.06, // Adjust size of the bookmark image
                  ),
                ),
              ),

              Positioned(
                bottom: 0, // Align to the top
                right: 0, // Align to the right
                child: Padding(
                  padding: EdgeInsets.only(right: w * 0.005, bottom: h * 0.002), // Add padding if you want some space from the edge
                  /*child: Image.asset(
                    'assets/ract_add.png',
                    width: w * 0.1, // Adjust size of the bookmark image
                  ),*/
                  child: SvgPicture.asset(
                    'assets/icons/add.svg',
                    width: w * 0.1, // Adjust size of the bookmark image
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
