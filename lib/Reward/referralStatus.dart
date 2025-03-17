import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class ReferralStatus extends StatefulWidget {
  const ReferralStatus({super.key});

  @override
  State<ReferralStatus> createState() => _ReferralStatusState();
}

class _ReferralStatusState extends State<ReferralStatus>{
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
                Text('Referral Status',
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
              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.02),
              child: ListView.builder(
                itemCount: 3,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index){
                    if(index == 0) {
                      return _buildItem(false);
                    }else {
                      return _buildItem(true);
                    }
                  }
              ),
            ),
          )
        ],
      ),

    );
  }

  Widget _buildItem(bool status){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
              child: Image.asset('assets/images/restaurent_logo.png',
                width: w * 0.23,
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: h * 0.014),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Satyug Restaurant Nagpur',
                  style: TextStyle(
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: fontSizes.fontSize12,
                    color: Colors.black
                  ),
                ),
                Visibility(
                  visible: !status,
                  child: Text('MIG F 2/9, Harihar Nagar, Nagpur',
                    style: TextStyle(
                        fontFamily: 'Poppins_regular',
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizes.fontSize10,
                        color: Color(0xFF606060)
                    ),
                  ),
                ),

                SizedBox(height: h * 0.01,),

                Visibility(
                  visible: !status,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: w * 0.005, bottom: w * 0.005),
                      child: Text('Pending',
                        style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize10,
                            color: Color(0xFF606060)
                        ),
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: status,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01, bottom: h * 0.01),
                      child: Text('Claim ₹1000',
                        style: TextStyle(
                            fontFamily: 'Poppins_semi_bold',
                            fontWeight: FontWeight.w600,
                            fontSize: fontSizes.fontSize12,
                            color: Color(0xFFF1F1F1)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
