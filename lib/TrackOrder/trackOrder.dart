import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class TrackOrder extends StatefulWidget {
  TrackOrder({Key? key, required this.latLong}) : super(key: key);

  LatLng latLong;


  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder>{

  late double w, h;
  late GoogleMapController mapController;
  late LatLng _userLatLong;
  late String lat;
  late String long;
  bool _isExpanded = false;
  bool isReceiptOpen = false;
  Position? _currentPosition;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLatLong = widget.latLong;
    lat = _userLatLong.latitude.toString();
    long = _userLatLong.longitude.toString();
    print('USER_LAT_LONG_TRACK_ORDER: ${_userLatLong}');
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
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: h * 0.048),
              child: GoogleMap(
                // onMapCreated: _onMapCreated,
                mapType: MapType.terrain,
                zoomControlsEnabled: false,
                // myLocationButtonEnabled: true,
                // myLocationEnabled: true,
                // markers: <Marker>{_setMarker()},
                initialCameraPosition:
                CameraPosition(target: _userLatLong, zoom: 20),
                onMapCreated: (GoogleMapController controllerMap) {
                  mapController = controllerMap;
                  _controller.complete(mapController);
                  // getCurrentLocation();
                },
               /* onCameraMove: (CameraPosition position) {
                  // This gets called every time the map is moved.
                  setState(() {
                    lat = position.target.latitude.toString();
                    long = position.target.longitude.toString();
                    print("Camera moved at: Lat: $lat, Long: $long");
                  });
                },*/
                onCameraIdle: () async {
                  // This gets called when the camera movement stops.
                  LatLng currentLatLng = await mapController
                      .getLatLng(ScreenCoordinate(x: w ~/ 2, y: h ~/ 2));
                  // _getAddressFromLatLng(currentLatLng);
                  print("Camera stopped at: Lat: $lat, Long: $long");
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: h * 0.12),
              child: SvgPicture.asset(
                'assets/icons/map_marker.svg',
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: h * 0.07, left: w * 0.04, right: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    // height: h * 0.05,
                    width: w * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 10,
                          spreadRadius: 10,
                          color:
                          Color.fromRGBO(0, 0, 0, 0.08),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.012, bottom: h * 0.012),
                      child: SvgPicture.asset('assets/icons/header_back.svg'),
                    ),
                  ),
                ),

                Container(
                  height: h * 0.04,
                  width: w * 0.13,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 6),
                        blurRadius: 10,
                        spreadRadius: 10,
                        color:
                        Color.fromRGBO(0, 0, 0, 0.08),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('Help',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Poppins_semi_bold',
                        color: Colors.black
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: !_isExpanded,
                      child: Padding(
                        padding: EdgeInsets.only(right: w * 0.04),
                        child: Container(
                          width: w * 0.34,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 10,
                                spreadRadius: 10,
                                color:
                                Color.fromRGBO(0, 0, 0, 0.08),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.05, top: h * 0.01, bottom: h * 0.01),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/navigation_arrow.svg'),
                                SizedBox(width: w * 0.02,),
                                Text('Track Order',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize12,
                                      fontFamily: 'Poppins_semi_bold',
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // This section is available for multiple section
                    /* SizedBox(height: h * 0.015,),
                    Visibility(
                      visible: !_isExpanded,
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF001FFF), // Start color
                                Color(0xFF001399),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 20,
                                spreadRadius: 20,
                                color:
                                Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.01, bottom: h * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.005),
                                  child: Image.asset('assets/icons/Prime_enable.png',
                                    width: w * 0.04,
                                  ),
                                ),

                                SizedBox(width: w * 0.03,),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Tap here to get ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_regular',  // Apply your custom font
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize12,
                                            color: Color(0xFFF9F9F9),  // White color for the first part
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: ShaderMask(
                                            shaderCallback: (bounds) => LinearGradient(
                                              colors: [Color(0xFFF8E0A5), Color(0xFFEA9A38)],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds),
                                            child: Text(
                                              'Living Menu Prime',
                                              style: TextStyle(
                                                fontFamily: 'Poppins_regular',  // Custom font
                                                fontWeight: FontWeight.w700,
                                                fontSize: fontSizes.fontSize12,
                                                color: Color(0xFFF9F9F9),  // This will be overridden by the gradient
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' and ₹29.90 off your next order.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize12,
                                            color: Color(0xFFF9F9F9),  // White color for the last part
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),*/

                    Padding(
                      padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, right: w * 0.04),
                      child: Stack(
                        children: [
                          Container(
                            width: w,
                            constraints: BoxConstraints(
                              maxHeight: _isExpanded ? h * 0.83 : h * 0.37, // Max height is 30% of screen
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 6),
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                  color:
                                  Color.fromRGBO(0, 0, 0, 0.08),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                width: w,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, top: h * 0.01, right: w * 0.04),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: _isExpanded,
                                            child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  _isExpanded = false;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(height: h * 0.01,),
                                                  SvgPicture.asset('assets/icons/cross_gray_bg.svg'),
                                                  SizedBox(height: h * 0.02,),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('Picking up your order',
                                              style: TextStyle(
                                                fontFamily: 'Supreme_bold',
                                                fontSize: fontSizes.fontSize24,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: h * 0.01,),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Arrives between ',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: fontSizes.fontSize12,
                                                        fontFamily: 'Poppins_regular',
                                                        color: Color(0xFF606060)
                                                      )
                                                    ),
                                                    TextSpan(
                                                        text: '11:51 PM-12:01 AM',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: fontSizes.fontSize12,
                                                            fontFamily: 'Poppins_regular',
                                                            color: Colors.black
                                                        )
                                                    )
                                                  ]
                                                )
                                            ),
                                          ),

                                          SizedBox(height: h * 0.02,),
                                          Row(
                                            children: [
                                              SvgPicture.asset('assets/icons/preparing_order_disable.svg'),
                                              Container(
                                                height: h * 0.005,
                                                width: w * 0.161,
                                                color: Color(0xFFE8E8E8),
                                              ),
                                              SvgPicture.asset('assets/icons/pickup_ready_disable.svg'),
                                              Container(
                                                height: h * 0.005,
                                                width: w * 0.161,
                                                color: Color(0xFFE8E8E8),
                                              ),
                                              SvgPicture.asset('assets/icons/on_the_way_disable.svg'),
                                              Container(
                                                height: h * 0.005,
                                                width: w * 0.161,
                                                color: Color(0xFFE8E8E8),
                                              ),
                                              SvgPicture.asset('assets/icons/delivered_disable.svg'),
                                            ],
                                          ),

                                          SizedBox(height: h * 0.02,),

                                          Text('Order is ready for pickup. Our delivery partner is arriving to get your order.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize12,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                          SizedBox(height: h * 0.02,)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: h * 0.001,
                                      width: w,
                                      color: Color(0xFFF1F1F1),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, right: w * 0.04),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Delivery Boy',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: fontSizes.fontSize16,
                                                    fontFamily: 'Poppins_semi_bold',
                                                    color: Colors.black
                                                ),
                                              ),
                                              Text('Abdul Ansari',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: fontSizes.fontSize12,
                                                    fontFamily: 'Poppins_regular',
                                                    color: Color(0xFF606060)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset('assets/icons/Phone.svg'),
                                              SizedBox(width: w * 0.02,),
                                              SvgPicture.asset('assets/icons/ChatText.svg'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: h * 0.02,),
                                    Container(
                                      height: h * 0.001,
                                      width: w,
                                      color: Color(0xFFF1F1F1),
                                    ),

                                    SizedBox(height: h * 0.02,),

                                    AnimatedSize(
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeInOut,
                                      child: Visibility(
                                        visible: _isExpanded,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Get More with Living Menu',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontSize: fontSizes.fontSize16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(AppStrings.GET_MORE_WITH_LIVING_MENU,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_regular',
                                                        fontSize: fontSizes.fontSize12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xFF606060),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.01,),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFFF1F1F1),
                                                          borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                                                          child: Text('Opt In',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_semi_bold',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.02,),
                                                    // Add more widgets as needed
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: h * 0.001,
                                                width: w,
                                                color: Color(0xFFF1F1F1),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset('assets/icons/gift.svg'),
                                                        SizedBox(width: w * 0.01,),
                                                        Text('Gift for - Liam Payne',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins_semi_bold',
                                                            fontSize: fontSizes.fontSize16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text('+91 7564834539',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_regular',
                                                        fontSize: fontSizes.fontSize12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xFF606060),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.01,),

                                                    Text('“Wishing you a birthday as perfect as you are for me”',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontSize: fontSizes.fontSize13,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.01,),
                                                    Text(AppStrings.GIFT_FOR,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_regular',
                                                        fontSize: fontSizes.fontSize12,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xFF606060),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.015,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFFF1F1F1),
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: w * 0.04,),
                                                              SvgPicture.asset('assets/icons/share_link.svg'),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.01, right: w * 0.04),
                                                                child: Text('Share Gift Link',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Poppins_semi_bold',
                                                                    fontSize: fontSizes.fontSize12,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: w * 0.03,),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFFF1F1F1),
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                                                            child: Text('Change Message',
                                                              style: TextStyle(
                                                                fontFamily: 'Poppins_semi_bold',
                                                                fontSize: fontSizes.fontSize12,
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: h * 0.02,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: h * 0.001,
                                                width: w,
                                                color: Color(0xFFF1F1F1),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Order Details',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontSize: fontSizes.fontSize16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.005,),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: 3,
                                                        itemBuilder: (context, index){
                                                          return _buildOrderItems();
                                                        }
                                                    ),
                                                    SizedBox(height: h * 0.01,),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          setState(() {
                                                            if(!isReceiptOpen){
                                                              isReceiptOpen = true;
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          width: w * 0.335,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFFF1F1F1),
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: w * 0.04,),
                                                              SvgPicture.asset('assets/icons/Receipt_track_order.svg'),

                                                              Padding(
                                                                padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.015, right: w * 0.04),
                                                                child: Text('View Receipt',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Poppins_semi_bold',
                                                                    fontSize: fontSizes.fontSize12,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.02,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: h * 0.001,
                                                width: w,
                                                color: Color(0xFFF1F1F1),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Special Instructions',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontSize: fontSizes.fontSize16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.015,),

                                                    IntrinsicHeight(
                                                      child: Container(
                                                        // height: h * 0.15,
                                                        width: w,
                                                        constraints: BoxConstraints(
                                                          minHeight: h * 0.15, // Replace with your desired minimum height
                                                        ),
                                                        padding:
                                                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: Color(0xFFF1F1F1),
                                                          // color: Colors.red,
                                                        ),
                                                        child: TextFormField(
                                                          maxLines: null, // Allows the text field to expand with multiple lines
                                                          textAlignVertical: TextAlignVertical.top,
                                                          cursorColor: Colors.red,
                                                          decoration: InputDecoration(
                                                            // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                                            floatingLabelBehavior:
                                                            FloatingLabelBehavior.never,
                                                            labelText: 'e.g. Don’t use cabbage and tomato sauce.',
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
                                                    ),
                                                    SizedBox(height: h * 0.02,),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFFF1F1F1),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                                                          child: Text('Edit',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_semi_bold',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
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
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Address',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontSize: fontSizes.fontSize16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.005,),
                                                    Container(
                                                      width: w * 0.6,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('1226 University Dr, Menlo Park, CA 94025, USA',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_regular',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Color(0xFF606060),
                                                            ),
                                                          ),
                                                          Text('Dropoff: Hand it to me',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_regular',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Color(0xFF606060),
                                                            ),
                                                          ),
                                                          Text('Landmark: In front of HDFC Bank',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_regular',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Color(0xFF606060),
                                                            ),
                                                          ),
                                                          Text('Instructions: Call me before you come.',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_regular',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w500,
                                                              color: Color(0xFF606060),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(height: h * 0.012,),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Container(
                                                        // width: w * 0.33,
                                                        decoration: BoxDecoration(
                                                            color: Color(0xFFF1F1F1),
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                                                          child: Text('Edit Instructions',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins_semi_bold',
                                                              fontSize: fontSizes.fontSize12,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: h * 0.02,),
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                    SizedBox(height: _isExpanded ? h * 0.07 : h * 0.05,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                              left: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(_isExpanded){
                                      _isExpanded = false;
                                    }else {
                                      _isExpanded = true;
                                    }
                                  });
                                },
                                child: Container(
                                  height: h * 0.07,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: h * 0.001,
                                        width: w,
                                        color: Color(0xFFF1F1F1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: h * 0.025),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _isExpanded ? 'View less details' : 'View all details',
                                              style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                              ),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            SvgPicture.asset(
                                                _isExpanded ? 'assets/icons/up_arrow_black.svg' : 'assets/icons/down_arrow_black.svg'
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.02,),
                  ],
                ),
              ),
          ),

          Positioned(
              bottom: h * 0.02,
              child: Visibility(
                visible: isReceiptOpen,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Container(
                    height: h * 0.77,
                    width: w * 0.92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 50,
                          spreadRadius: 20,
                          color:
                          Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(isReceiptOpen){
                                          isReceiptOpen = false;
                                        }
                                      });
                                    },
                                      child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                                  ),
                                  SizedBox(height: h * 0.02,),
                                  Container(
                                    height: h * 0.35,
                                    color: Colors.white,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: 9, // Make sure to set the item count
                                      itemBuilder: (context, index) {
                                        return _buildReceiptItem();
                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.03,),
                            Container(
                              width: w,
                              height: h * 0.001,
                              color: Color(0xFFF1F1F1),
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.04),
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
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.005, bottom: h * 0.005),
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
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
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
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
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
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
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
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.006),
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


                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(isReceiptOpen){
                                    isReceiptOpen = false;
                                  }else {
                                    isReceiptOpen = true;
                                  }
                                });
                              },
                              child: Container(
                                height: h * 0.07,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h * 0.001,
                                      width: w,
                                      color: Color(0xFFF1F1F1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * 0.025),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            isReceiptOpen ? 'View less details' : 'View all details',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset(
                                              isReceiptOpen ? 'assets/icons/up_arrow_black.svg' : 'assets/icons/down_arrow_black.svg'
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        )

                      ],
                    ),
                  ),
                ),
              )
          ),
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

  Widget _buildOrderItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Text('2x Cheese Pizza',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSizes.fontSize12,
        fontFamily: 'Poppins_regular',
        color: Color(0xFF606060)
      ),
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
