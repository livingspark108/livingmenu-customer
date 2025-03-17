import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';

import '../Constants/appFontSizes.dart';

class SelectRestaurantOutlet extends StatefulWidget {
  const SelectRestaurantOutlet({super.key});

  @override
  State<SelectRestaurantOutlet> createState() => _SelectRestaurantOutletState();
}

class _SelectRestaurantOutletState extends State<SelectRestaurantOutlet>{
  int? _selectedIndex;
  bool isLocationSelected = false;
  late double w, h;



  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF4FD),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.008, bottom: h * 0.008, left: w * 0.08, right: w * 0.04),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: h * 0.005,
                          width: w * 0.01,
                          decoration: BoxDecoration(
                            color: Color(0xFFE43DC8),
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        Text('Jaipur',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: fontSizes.fontSize16,
                              fontFamily: 'Poppins_regular',
                              color: Color(0xFFE43DC8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: h * 0.04,),
                Text('Choose \nOutlet',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSizes.fontSize40,
                      fontFamily: 'Archivo_bold',
                      color: Colors.black,
                      height: 1
                  ),
                ),
                SizedBox(height: h * 0.025,),
                Expanded(
                  child: ListView.builder(
                      itemCount: 2,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            _selectedIndex = index;
                            setState(() {
                              isLocationSelected = true;
                            });
                          },
                          child: Column(
                            children: [
                              _buildItems(_selectedIndex == index),
                              SizedBox(height: h * 0.02,)
                            ],
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: h * 0.2,)
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: h * 0.065,
                              width: w * 0.25,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text('Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.03,),

                          GestureDetector(
                            onTap: (){
                              if (isLocationSelected) {
                                Navigator.pushAndRemoveUntil(context,
                                    AnimatedRoute.createRouteRightToLeft(
                                        MainScreen()), (route) => false);
                              }
                            },
                            child: Container(
                              height: h * 0.065,
                              width: w * 0.62,
                              decoration: BoxDecoration(
                                  color: isLocationSelected ? Color(0xFF001FFF) : Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text('Explore App',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: isLocationSelected ? Colors.white : Color(0xFF606060)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.05,),

                    Row(
                      children: [
                        Container(
                          height: h * 0.006,
                          width: w * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        Container(
                          height: h * 0.006,
                          width: w * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: h * 0.05,),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildItems(bool isSelected){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      width: w,
      height: h * 0.08,
      decoration: BoxDecoration(
          color: Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // I want to hide and show this container on item click
              Visibility(
                visible: isSelected,
                child: Container(
                  height: h * 0.08,
                  width: w * 0.02,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )
                  ),
                ),
              ),
              SizedBox(width: w * 0.03,),
              Text('Vaishali Nagar',
                style: TextStyle(
                    fontFamily: 'Poppins_regular',
                    fontSize: fontSizes.fontSize16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            ],
          ),
          Visibility(
            visible: isSelected,
            child: Container(
              height: h * 0.08,
              width: w * 0.02,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

}
