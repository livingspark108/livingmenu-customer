import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/TakeAway/takeawayOrderPlace.dart';

class TakeawayTime extends StatefulWidget {
  const TakeawayTime({Key? key}) : super(key: key);

  @override
  State<TakeawayTime> createState() => _TakeawayTimeState();
}

class _TakeawayTimeState extends State<TakeawayTime>{
  late double w, h;
  List<Map<String, String>> days = [];
  List<Map<String, String>> timeSlots = [];
  int selectedIndex = 0; // Track the selected index (-1 means none selected)
  int selectedTimeSlotIndex = 0; // Track the selected index (-1 means none selected)
  List<String> times = [
    '24 min', '6:00 PM-6:20 PM', '6:20 PM-6:40 PM', '6:40 PM-7:00 PM', '7:00 PM-7:20 PM', '7:20 PM-7:40 PM', '8:00 PM-8:20PM', '8:20 PM-8:40 PM', '8:40 PM-9:00 PM', '9:00 PM-9:20 PM', '9:20 PM-9:40 PM', '9:40 PM-10:00 PM'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateWeekDays();
    generateTimeSlots();
  }



  void generateWeekDays() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime day = now.add(Duration(days: i));
      String label;

      if (i == 0) {
        label = 'Today';
      } else if (i == 1) {
        label = 'Tomorrow';
      } else {
        label = DateFormat('EEEE').format(day); // Get weekday name (e.g., Monday)
      }

      days.add({
        'day': label,
        'date': DateFormat('dd MMM').format(day)  // e.g., 'Oct 12'
      });
    }
    days.add({
      'day': 'Custom',
      'date': 'Choose Date'
    });

  }

  void generateTimeSlots(){
    for(int i = 0; i < times.length; i++){
      String timeSlot = times[i];
      String msg = '';
      if (i == 0){
        msg = 'Standard';
      }
      timeSlots.add({
        'msg': msg,
        'time': timeSlot,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Stack(
          children: [
            Column(
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
                      Text('Takeaway Time',
                        style: TextStyle(
                            fontFamily: 'Supreme_bold',
                            fontWeight: FontWeight.w700,
                            fontSize: fontSizes.fontSize24
                        ),
                      ),
                      SizedBox(height: h * 0.01,),
                      Text('Choose an available time for your delivery.',
                        style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize14,
                            color: Color(0xFF939393)
                        ),
                      ),
                      SizedBox(height: h * 0.015,),
                      Container(
                        height: h * 0.063, // Adjust height for horizontal list
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      selectedIndex = index;
                                      if(selectedIndex == 7){
                                        _showBottomPopup(context);
                                      }
                                    });
                                  },
                                  child: _buildDayItems(index, days[index]['day']!, days[index]['date']!, selectedIndex),
                                ),
                                SizedBox(width: w * 0.035,)
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        height: h * 0.6,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            //   physics: NeverScrollableScrollPhysics(),
                            itemCount: timeSlots.length,
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState(() {
                                        selectedTimeSlotIndex = index;
                                      });
                                    },
                                    child: _buildTimeSlotItems(index, timeSlots[index]['msg']!, timeSlots[index]['time']!, selectedTimeSlotIndex),
                                  )
                                ],
                              );
                            }
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),

            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: h * 0.15,
                  width: w,
                  color: Colors.white,

                  child: Column(
                    children: [
                      Container(
                        height: h * 0.001,
                        width: w,
                        color: Color(0xFFF1F1F1),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(TakeawayOrderPlace()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.022),
                          child: Container(
                            height: h * 0.06,
                            width: w,
                            decoration: BoxDecoration(
                                color: Color(0xFF001FFF),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('Update',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: h * 0.06,
                        width: w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text('Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            )

          ],
        ),
      ),
    );
  }

  /*void _showBottomPopup(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Optional: makes the corners rounded if you add a radius
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
          child: Container(
            height: 320,
            width: w,// Adjust height as needed
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),

            // This column taking unwanted padding from left and right
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02,),
                    Center(
                      child: Container(
                        width: w * 0.4,
                        height: h * 0.008,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Custom Date',
                            style: TextStyle(
                              fontFamily: 'Supreme_bold',
                              fontSize: fontSizes.fontSize24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            ),
                          ),
                          Text('Choose an available time for your delivery.',
                            style: TextStyle(
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF939393)
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.2,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),
                              // SizedBox(width: w * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Month',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.2,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),

                              // SizedBox(width: w * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Year',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.35,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: h * 0.02,),

                Container(
                  height: h * 0.001,
                  width: w,
                  color: Color(0xFFF1F1F1),
                ),

                SizedBox(height: h * 0.02,),

                Container(
                  height: h * 0.05,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFF001FFF),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('Update',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.005,),
                Container(
                  height: h * 0.06,
                  width: w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }*/









  void _showBottomPopup(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Optional: makes the corners rounded if you add a radius
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, bottom: MediaQuery.of(context).viewInsets.bottom, ),
          child: Container(
            height: 320,
            width: w,// Adjust height as needed
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),

            // This column taking unwanted padding from left and right
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02,),
                    Center(
                      child: Container(
                        width: w * 0.4,
                        height: h * 0.008,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Custom Date',
                            style: TextStyle(
                                fontFamily: 'Supreme_bold',
                                fontSize: fontSizes.fontSize24,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),
                          ),
                          Text('Choose an available time for your delivery.',
                            style: TextStyle(
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF939393)
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.2,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),
                              // SizedBox(width: w * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Month',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.2,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              ),

                              // SizedBox(width: w * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Year',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    height: h * 0.05,
                                    width: w * 0.35,
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
                                      decoration: InputDecoration(
                                        // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: '',
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
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: h * 0.02,),

                Container(
                  height: h * 0.001,
                  width: w,
                  color: Color(0xFFF1F1F1),
                ),

                SizedBox(height: h * 0.02,),

                Container(
                  height: h * 0.05,
                  width: w * 0.8,
                  decoration: BoxDecoration(
                      color: Color(0xFF001FFF),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text('Update',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.005,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: h * 0.08,
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins_semi_bold',
                          fontSize: fontSizes.fontSize16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }








  Widget _buildDayItems(int index, String day, String date, int selectedIndex){
    AppFontSizes fontSizes = AppFontSizes(context);
    bool isSelected = index == selectedIndex;
    return Container(
      width: w * 0.31,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? Colors.black : Color(0xFFF1F1F1),
              width: 1
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.009),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(day,
                  style: TextStyle(
                      fontSize: fontSizes.fontSize14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular'
                  ),
                ),
                SvgPicture.asset(
                    isSelected ? 'assets/icons/tick_checked.svg'
                        : 'assets/icons/tick_unchecked.svg'
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
            child: Text(date,
              style: TextStyle(
                  fontSize: fontSizes.fontSize12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins_regular',
                  height: 1,
                  color: Color(0xFF7B7B7B)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotItems(int index, String msg, String timeSlot, int selectedIndex){
    AppFontSizes fontSizes = AppFontSizes(context);
    bool isSelected = index == selectedIndex;
    return Container(
      // height: h * 0.05,
      child: Padding(
        padding: EdgeInsets.only(top: h * 0.018),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: index == 0 ? EdgeInsets.only(top: h * 0.015) : EdgeInsets.only(top: h * 0.005),
              child: SvgPicture.asset(
                  isSelected ? 'assets/icons/tick_checked.svg'
                      : 'assets/icons/tick_unchecked.svg'
              ),
            ),
            SizedBox(width: w * 0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: index == 0,
                  child: Text(msg,
                    style: TextStyle(
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Poppins_regular',
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Text(timeSlot,
                  style: TextStyle(
                      fontSize: fontSizes.fontSize14,
                      fontFamily: 'Poppins_regular',
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: h * 0.018,),
                Container(
                  height: h * 0.001,
                  width: w * 0.86,
                  color: Color(0xFFF1F1F1),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
