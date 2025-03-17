import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/RestaurantOutlets/selectRestaurantOutlet.dart';

import '../Constants/appFontSizes.dart';

class SelectRestaurantLocation extends StatefulWidget {
  const SelectRestaurantLocation({super.key});

  @override
  State<SelectRestaurantLocation> createState() => _SelectRestaurantLocationState();
}

class _SelectRestaurantLocationState extends State<SelectRestaurantLocation>{
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
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.15),
            child: Column(
              children: [
                Text('Choose Location',
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
                    itemCount: 10,
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
                      child: GestureDetector(
                        onTap: (){
                          if(isLocationSelected){
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(SelectRestaurantOutlet()));
                          }
                        },
                        child: Container(
                          height: h * 0.065,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            color: isLocationSelected ? Colors.black : Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Choose Outlet',
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
                    ),
                    SizedBox(height: h * 0.05,),

                    Row(
                      children: [
                        Container(
                          height: h * 0.006,
                          width: w * 0.035,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                        ),
                        SizedBox(width: w * 0.02,),
                        Container(
                          height: h * 0.006,
                          width: w * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
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
              Text('JAIPUR',
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
