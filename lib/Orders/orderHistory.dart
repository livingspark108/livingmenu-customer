import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Constants/appFontSizes.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>{
  late double w,h;
  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
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
                Text('Order ID: #9873434324',
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
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order Details',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: h * 0.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Delivered to',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Color(0xFF606060),
                                    ),
                                  ),
                                  Text('Harsh Parmar',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
            
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Contact',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Color(0xFF606060),
                                    ),
                                  ),
                                  Text('+91 7410912340',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
            
                          SizedBox(height: h * 0.01,),
            
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Color(0xFF606060),
                                ),
                              ),
                              Text('Delivery to: 43 CA-Malviya Nagar, Jaipur',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins_regular',
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.03,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.013, bottom: h * 0.013),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('assets/icons/headphone_white.svg'),
                                  SizedBox(width: w * 0.02,),
                                  Text('Get Help',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize13,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Supreme_bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Container(
                      height: h * 0.01,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),
                    SizedBox(height: h * 0.02,),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Give Feedback',
                            style: TextStyle(
                              fontSize: fontSizes.fontSize16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: h * 0.01,),
                          Text(
                            'How was the food quality?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.005,),
            
                          RatingBar(
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              half: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              empty: SvgPicture.asset(
                                'assets/icons/star_blank.svg',
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              print('Rating: $rating');
                            },
                            initialRating: 0,
                            minRating: 0,
                            itemSize: w * 0.05,
                            allowHalfRating: false,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          ),
            
                          SizedBox(height: h * 0.01,),
            
                          Text(
                            'How was your delivery experience?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.005,),
            
                          RatingBar(
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              half: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              empty: SvgPicture.asset(
                                'assets/icons/star_blank.svg',
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              print('Rating: $rating');
                            },
                            initialRating: 0,
                            minRating: 0,
                            itemSize: w * 0.05,
                            allowHalfRating: false,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          ),
                          SizedBox(height: h * 0.01,),
            
                          Text(
                            'How was the packaging quality?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.005,),
                          RatingBar(
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              half: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              empty: SvgPicture.asset(
                                'assets/icons/star_blank.svg',
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              print('Rating: $rating');
                            },
                            initialRating: 0,
                            minRating: 0,
                            itemSize: w * 0.05,
                            allowHalfRating: false,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          ),
            
                          SizedBox(height: h * 0.01,),
            
                          Text(
                            'How was hygiene?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins_regular',
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.005,),
                          RatingBar(
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              half: SvgPicture.asset(
                                'assets/icons/star_fill.svg',
                              ),
                              empty: SvgPicture.asset(
                                'assets/icons/star_blank.svg',
                              ),
                            ),
                            onRatingUpdate: (rating) {
                              print('Rating: $rating');
                            },
                            initialRating: 0,
                            minRating: 0,
                            itemSize: w * 0.05,
                            allowHalfRating: false,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          ),
            
                          SizedBox(height: h * 0.02,),
            
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.013, bottom: h * 0.013),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Supreme_bold',
                                  fontSize: fontSizes.fontSize13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Container(
                      height: h * 0.01,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),
                    SizedBox(height: h * 0.02,),
            
            
            
            
            
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Receipt',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins_semi_bold',
                                      fontSize: fontSizes.fontSize16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.02,),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 4, // Make sure to set the item count
                                    itemBuilder: (context, index) {
                                      return _buildReceiptItem();
                                    },
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.005,),
                            Container(
                              width: w,
                              height: h * 0.001,
                              color: Color(0xFFF1F1F1),
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹120.00',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: h * 0.006,),
                            Container(
                              color: Color(0xFFEEF0FF),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.005, bottom: h * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Fee',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizes.fontSize14,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),

                                    Text('₹0.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSizes.fontSize14,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.006,),
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Platform Fee',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹3.21',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Restaurant Charges',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹10.41',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Estimated Tax',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('₹83.04',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize14,
                                        fontFamily: 'Poppins_regular',
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.006),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_semi_bold',
                                        color: Colors.black
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _buildTextWithLine('₹210.04'),
                                      SizedBox(width: w * 0.005,),
                                      Text('₹198.56',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize16,
                                            fontFamily: 'Poppins_semi_bold',
                                            color: Color(0xFF001FFF)
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Savings',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF001FFF)
                                ),
                              ),
                              Text('₹12.52',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF001FFF)
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.02,),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF001FFF),
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.013, bottom: h * 0.013),
                              child: Text(
                                'Order Again',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Supreme_bold',
                                  fontSize: fontSizes.fontSize13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.03,),
                        ],
                      ),
                    )
            
            
            
            
            
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextWithLine(String text) {
    AppFontSizes fontSizes = AppFontSizes(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the width of the text by using the TextPainter
        final TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSizes.fontSize14,
              fontFamily: 'Poppins_semi_bold',
              color: Color(0xFF939393),
              fontWeight: FontWeight.w500,
            ),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        // Get the width of the text
        double textWidth = textPainter.width;

        return Stack(
          alignment: Alignment.center, // Align children at the center
          children: [
            // This is the line, adjusted according to the text width
            Container(
              width: textWidth + w * 0.01,  // Line width slightly larger than the text width
              height: h * 0.001,  // Line thickness
              color: Color(0xFF939393), // Line color
            ),
            // This is the text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding if needed
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSizes.fontSize14,
                  fontFamily: 'Poppins_semi_bold',
                  color: Color(0xFF939393),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReceiptItem(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('1',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizes.fontSize12,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black
                  ),
                ),
                SizedBox(width: w * 0.02,),
                Text('Double Whopper',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizes.fontSize12,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black
                  ),
                ),
              ],
            ),
            Text('₹56.9',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSizes.fontSize12,
                  fontFamily: 'Poppins_regular',
                  color: Colors.black
              ),
            )
          ],
        ),
        SizedBox(height: h * 0.005,),
        Padding(
          padding: EdgeInsets.only(left: w * 0.03),
          child: Text('Add Mustard, Add BQ Sauce',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSizes.fontSize12,
                fontFamily: 'Poppins_regular',
                color: Color(0xFF606060)
            ),
          ),
        ),
        SizedBox(height: h * 0.02,),
      ],
    );
  }

}
