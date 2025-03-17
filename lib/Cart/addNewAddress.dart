import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Cart/addressBook.dart';
import 'package:living_menu_mobile/Cart/cartOrderPlace.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/CustomItems/errorPopup.dart';
import 'package:living_menu_mobile/Settings/addressListForEdit.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/animatedRoute.dart';
import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({Key? key,
    required this.latLong,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.areaName,
    required this.localArea,
    required this.country,

  }) : super(key: key);

  LatLng latLong;
  String state;
  String city;
  String pinCode;
  String areaName;
  String localArea;
  String country;

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  late double w, h;
  bool isHandToMeSelected = true;
  late LatLng _userLatLong;
  double? latitude;
  double? longitude;
  bool isGift = false;
  bool isLoading = false;
  TextEditingController floorController = TextEditingController();
  TextEditingController entryCodeController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController deliveryInstructionController = TextEditingController();
  TextEditingController addressLabelController = TextEditingController();
  ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLatLong = widget.latLong;
    latitude = _userLatLong.latitude;
    longitude = _userLatLong.longitude;
    stateController.text = widget.state;
    cityController.text = widget.city;
    pinCodeController.text = widget.pinCode;
    print('USER_LAT_LONG_ADD_NEW: ${_userLatLong}');
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    final staticMapUrl =
        'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=530x200&markers=color:black|$latitude,$longitude&key=${AppStrings.GOOGLE_MAP_API_KEY}';

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: isLoading,
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.06),
                            child: Row(
                              children: [
                                IconButton(
                                  icon:
                                  SvgPicture.asset('assets/icons/header_back.svg'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Text(
                                  'Add New Address',
                                  style: TextStyle(
                                      fontFamily: 'Supreme_bold',
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizes.fontSize24,
                                      color: Colors.black
                                    // fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.012,),
                        Container(
                          height: h * 0.001,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        )
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                            child: Text(
                              'Landmark',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.black
                                // fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.01),
                            child: Container(
                              height: h * 0.16,
                              width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(staticMapUrl,
                                  // width: w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                            child: Text(
                              widget.areaName,
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize14,
                                  color: Colors.black
                                // fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04),
                            child: Text(
                              widget.localArea,
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF606060)
                                // fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.03,),
                          Container(
                            height: h * 0.01,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, right: w * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enter Complete Details',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.black
                                    // fontSize: 18
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
                                          'Floor/Apartment/Suite',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize12,
                                              color: Colors.black
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
                                            controller: floorController,
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
                                          'Entry Code',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize12,
                                              color: Colors.black
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
                                            controller: entryCodeController,
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
                                SizedBox(height: h * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Building Name*',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,),
                                    Container(
                                      height: h * 0.05,
                                      width: w * 0.92,
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        controller: buildingNameController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          // labelTFext: '',
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

                                SizedBox(height: h * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Full Address*',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,),
                                    Container(
                                      height: h * 0.05,
                                      width: w * 0.92,
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        controller: fullAddressController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'Enter Complete Address',
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


                                SizedBox(height: h * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mobile Number*',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,),
                                    Container(
                                      height: h * 0.05,
                                      width: w * 0.92,
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        controller: mobileController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'Enter Mobile Number',
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


                                SizedBox(height: h * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Landmark',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,),
                                    Container(
                                      height: h * 0.05,
                                      width: w * 0.92,
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        controller: landmarkController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'Add Nearby location',
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

                                SizedBox(height: h * 0.02,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'State*',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                    SizedBox(height: h * 0.01,),
                                    Container(
                                      height: h * 0.05,
                                      width: w * 0.92,
                                      alignment: Alignment.center,
                                      padding:
                                      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF1F1F1),
                                        // color: Colors.red,
                                      ),
                                      child: TextFormField(
                                        controller: stateController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'Enter State',
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

                                SizedBox(height: h * 0.02,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'City*',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize12,
                                              color: Colors.black
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
                                            controller: cityController,
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
                                          'Pin Code*',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize12,
                                              color: Colors.black
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
                                            controller: pinCodeController,
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

                                SizedBox(height: h * 0.02,),
                                Text(
                                  'Drop-off Options',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.black
                                    // fontSize: 18
                                  ),
                                ),
                                SizedBox(height: h * 0.01,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isHandToMeSelected = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: isHandToMeSelected ? Colors.black : Color(0xFFF1F1F1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015, bottom: h * 0.015),
                                          child: Text(
                                            'Hand it to me',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize16,
                                                color: isHandToMeSelected ? Colors.white : Colors.black
                                              // fontSize: 18
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: w * 0.03,),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isHandToMeSelected = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: !isHandToMeSelected ? Colors.black : Color(0xFFF1F1F1),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015, bottom: h * 0.015),
                                          child: Text(
                                            'Leave it at my door',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize16,
                                                color: !isHandToMeSelected ? Colors.white : Colors.black
                                              // fontSize: 18
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(height: h * 0.02,),

                                Container(
                                  height: h * 0.12,  // Define the desired height
                                  width: w,  // Set the width as per requirement
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),  // Circular corners
                                    color: Color(0xFFF1F1F1),  // Background color
                                  ),
                                  child: TextFormField(
                                    controller: deliveryInstructionController,
                                    cursorColor: Colors.red,
                                    maxLines: null,  // Allow multiple lines
                                    // keyboardType: TextInputType.multiline,  // Multiline input
                                    decoration: InputDecoration(
                                      hintText: 'e.g. ring the bell after dropoff, leave next to the porch, call upon arrival, etc.',  // Placeholder text
                                      hintMaxLines: 3,
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular',
                                        color: Color(0xFF606060),  // Placeholder text color
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFF1F1F1),  // Same as container background
                                      contentPadding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.03),  // Adjust padding for proper spacing
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),  // Circular corners for the input field
                                        borderSide: BorderSide.none,  // No border line
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: h * 0.015,),
                          Container(
                            height: h * 0.01,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, right: w * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address Label*',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      color: Colors.black
                                    // fontSize: 18
                                  ),
                                ),
                                SizedBox(height: h * 0.01,),
                                Stack(
                                  children: [
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
                                        controller: addressLabelController,
                                        cursorColor: Colors.red,
                                        decoration: InputDecoration(
                                          // SvgPicture.asset('assets/icons/search_gray.svg',),

                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          labelText: 'Enter Address Label',
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
                                    Align(
                                      alignment: Alignment.centerRight,
                                        child: Container(
                                          width: w * 0.1,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: h * 0.015,),
                                            child: SvgPicture.asset('assets/icons/rounded_cross_black.svg',),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                SizedBox(height: h * 0.01,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF0F2FF),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.012, bottom: h * 0.012),
                                    child: Text(
                                      AppStrings.SAVE_ADDRESS_LABEL,
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          color: Colors.black
                                        // fontSize: 18
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),

                          SizedBox(height: h * 0.015,),
                          Container(
                            height: h * 0.01,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/unchecked_ractangle.svg'),
                                    SizedBox(width: w * 0.025,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'I’m sending a gift',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                              color: Colors.black
                                            // fontSize: 18
                                          ),
                                        ),
                                        Text(
                                          'Add a note at checkout',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize12,
                                              color: Color(0xFF606060)
                                            // fontSize: 18
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SvgPicture.asset('assets/icons/info_icon.svg'),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.04,),
                          Container(
                            height: h * 0.001,
                            width: w,
                            color: Color(0xFFF1F1F1),
                          ),

                          SizedBox(height: h * 0.1,),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
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
                      Container(
                        height: h * 0.001,
                        width: w,
                        color: Color(0xFFF1F1F1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.022),
                        child: GestureDetector(
                          onTap: () async {
                            if(buildingNameController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter building name'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(fullAddressController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter full address'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(mobileController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter mobile number'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(stateController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter state name'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(cityController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter city name'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(pinCodeController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter pin code'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(addressLabelController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter address label'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else {
                              setState(() {
                                isLoading = true;
                              });
                              String dropOff = '';
                              if(isHandToMeSelected){
                                dropOff = 'Hand it to me';
                              }else {
                                dropOff = 'Leave it at my door';
                              }
                              final prefs = await SharedPreferences.getInstance();
                              String userId = await prefs.getInt('userId').toString();
                              bool isComeFrom = await prefs.getBool('isComeFromAddressBook') ?? false;
                              apiService.addAddress(
                                  context,
                                  'false',
                                  'true',
                                  addressLabelController.text,
                                  floorController.text,
                                  mobileController.text,
                                  latitude.toString(),
                                  longitude.toString(),
                                  landmarkController.text,
                                  widget.areaName,
                                  pinCodeController.text,
                                  cityController.text,
                                  stateController.text,
                                  widget.country,
                                  'false',
                                  '',
                                  floorController.text,
                                  dropOff,
                                  entryCodeController.text,
                                  'false',
                                  fullAddressController.text,
                                  deliveryInstructionController.text,
                                  userId).then((onValue){
                                    final response = onValue;
                                    if(response.statusCode == 201){
                                      ErrorPopup.showGlobalPopup(
                                          context: context,
                                          title: 'Success',
                                          titleColor: Colors.green,
                                          message: 'Address added successfully.',
                                          buttonText: 'OK',
                                          buttonTextColor: Colors.black
                                      );
                                      if(isComeFrom) {
                                        Navigator.push(context, AnimatedRoute
                                            .createRouteRightToLeft(
                                            AddressBook()));
                                      }else {
                                        Navigator.push(context, AnimatedRoute
                                            .createRouteRightToLeft(
                                            AddressListForEdit()));
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                              });

                            }

                          },
                          child: Container(
                            height: h * 0.055,
                            width: w,
                            decoration: BoxDecoration(
                                color: Color(0xFF001FFF),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
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
      ),
    );
  }

}
