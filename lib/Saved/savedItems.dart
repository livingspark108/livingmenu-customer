import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/appFontSizes.dart';
import '../Constants/appStrings.dart';
import '../Models/savedProductModel.dart';
import '../network/apiService.dart';

class SavedItems extends StatefulWidget {
  const SavedItems({super.key});

  @override
  State<SavedItems> createState() => _SavedItemsState();
}

class _SavedItemsState extends State<SavedItems>{
  late double w,h;
  ApiService apiService = ApiService();
  List<SavedProductModel>? productModel;
  bool _isLoading = false;
  bool isSavedItemAvailable = false;

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
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
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
                  Text('Saved Items',
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
            SizedBox(height: h * 0.015,),

            Visibility(
              visible: isSavedItemAvailable,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                    child: ListView.builder(
                      itemCount: productModel?.length ?? 0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (contaex, index){
                          Product? product = productModel![index].product;
                          return Column(
                            children: [
                              _buildItems(context, product),
                              SizedBox(height: h * 0.02)
                            ],
                          );
                        }
                    ),
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
                  Text(product?.title ?? '',
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
