import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/BookParty/partySelectHall.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../Constants/animatedRoute.dart';

class BookPartyLandingScreen extends StatefulWidget {
  const BookPartyLandingScreen({super.key});

  @override
  State<BookPartyLandingScreen> createState() => _BookPartyLandingScreenState();
}

class _BookPartyLandingScreenState extends State<BookPartyLandingScreen>{
  late double w, h;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2100), // Latest date selectable
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // You can customize the theme here
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }



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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.06, left: w * 0.04, right: w * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/header_back.svg',
                            width: w * 0.04,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // _showAddressPopup(context);
                          },
                          child: Container(
                            child: Row(
                              children: [

                                SizedBox(width: w * 0.03,),
                                Text('Jaipur',
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
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Notifications()));
                          },
                          child: SvgPicture.asset(
                            'assets/icons/notification_icon.svg',
                            width: w * 0.08,
                          ),
                        ),
                        SizedBox(width: w * 0.025,),
                        GestureDetector(
                          onTap: (){
                            // Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                          },
                          child: SvgPicture.asset(
                            'assets/icons/cart_bag_icon.svg',
                            width: w * 0.06,
                          ),
                        ),
                        SizedBox(width: w * 0.03,),
                        GestureDetector(
                          onTap: (){
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => const Profile()));
                          },
                          child: Container(
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: h * 0.015,),
              Container(
                width: w,
                height: h * 0.038,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFDCD3FF),
                      Color(0xFFEDBEFF),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Booked Party',
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
                          Text('Tomorrow, 2:40 AM',
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
              Padding(
                padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Basic Details',
                      style: TextStyle(
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: h * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              width: w * 0.445,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              width: w * 0.445,
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
                      ],
                    ),

                    SizedBox(height: h * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Country',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              padding: EdgeInsets.zero,
                              /*constraints: BoxConstraints(
                                      maxWidth: w * 0.2, // Adjust based on your layout
                                    ),*/
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFF1F1F1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CountryCodePicker(
                                    padding: EdgeInsets.zero,
                                    showFlag: false,
                                    initialSelection: 'IN',
                                    // showDropDownButton: true,
                                  ),
                                  SvgPicture.asset('assets/icons/arrow_down_black_small.svg'),
                                  SizedBox(width: w * 0.04,)
                                ],
                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              width: w * 0.65,
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

                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.03,),
              Container(
                height: h * 0.001,
                width: w,
                color: Color(0xFFF1F1F1),
              ),
              SizedBox(height: h * 0.01,),





              Padding(
                padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Party Details',
                      style: TextStyle(
                          fontFamily: 'Poppins_semi_bold',
                          fontSize: fontSizes.fontSize16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: h * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Occasion',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              width: w * 0.635,
                              alignment: Alignment.center,
                              padding:
                              EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFF1F1F1),
                                // color: Colors.red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Birthday',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Poppins_regular',
                                      color: Colors.black,
                                      height: 1
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.006),
                                    child: SvgPicture.asset('assets/icons/arrow_down_black_small.svg'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invitations',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            Container(
                              height: h * 0.05,
                              width: w * 0.25,
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
                      ],
                    ),

                    SizedBox(height: h * 0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),

                            GestureDetector(
                              onTap: (){
                                _selectDate(context);
                              },
                              child: Container(
                                height: h * 0.05,
                                width: w * 0.36,
                                alignment: Alignment.center,
                                padding:
                                EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFF1F1F1),
                                  // color: Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(selectedDate != null
                                        ? "${selectedDate!.toLocal()}".split(' ')[0]
                                        : "",

                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),
                                    SvgPicture.asset('assets/icons/arrow_down_black_small.svg')

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Time',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            GestureDetector(
                              onTap: (){
                                _selectStartTime(context);
                              },
                              child: Container(
                                height: h * 0.05,
                                width: w * 0.24,
                                alignment: Alignment.center,
                                padding:
                                EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFF1F1F1),
                                  // color: Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(selectedStartTime != null
                                  ? "${selectedStartTime!.format(context)}" : '',

                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),
                                    SvgPicture.asset('assets/icons/arrow_down_black_small.svg')

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Time',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                            SizedBox(height: h * 0.01,),
                            GestureDetector(
                              onTap: (){
                                _selectEndTime(context);
                              },
                              child: Container(
                                height: h * 0.05,
                                width: w * 0.24,
                                alignment: Alignment.center,
                                padding:
                                EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFF1F1F1),
                                  // color: Colors.red,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(selectedEndTime != null
                                  ? "${selectedEndTime!.format(context)}" : '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          fontFamily: 'Poppins_regular',
                                          color: Colors.black
                                      ),
                                    ),
                                    SvgPicture.asset('assets/icons/arrow_down_black_small.svg')

                                  ],
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





            ],
          ),


          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: h * 0.1,
                width: w,
                color: Colors.white,
                child: Column(
                  children: [
                   /* Container(
                      height: h * 0.001,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),*/
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.022),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(PartySelectHall()));
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                              // color: Color(0xFF001FFF),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFCE00DC),
                                  Color(0xFF011EF4),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              'Choose Hall',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.white
                                // fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),


        ],
      ),
    );
  }

}
