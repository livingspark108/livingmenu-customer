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

class DineInTrackOrder extends StatefulWidget {
  DineInTrackOrder({Key? key, required this.latLong}) : super(key: key);

  LatLng latLong;

  @override
  State<DineInTrackOrder> createState() => _DineInTrackOrderState();
}

class _DineInTrackOrderState extends State<DineInTrackOrder>{
  late double w, h;
  late GoogleMapController mapController;
  late LatLng _userLatLong;
  late String lat;
  late String long;
  bool _isExpanded = false;
  bool isReceiptOpen = false;
  bool isRequestOpen = false;
  Position? _currentPosition;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  int selectedCatIndex = 0;
  int addOnsFirstItemSelectedIndex = 0;
  Map<int, bool> _addOnClickedStatus = {};
  int selectedMonthIndex = 0;

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

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

    List<String> category = [
      'Starter', 'Ice Cream', 'Desert', 'North Indian', 'South Indian', 'Fast Food', 'Chicken', 'Fish', 'Sea Foods', 'Italian Food', 'Chinese Food', 'Dec'
    ];
    /*List<String> categoryList = [];
    for (int i = currentCatIndex; i >= 0; i--) {
      categoryList.add(category[i]);
    }*/
    List<String> categoryList = List.from(category);
    List<String> productAddOnsList = List.from(productAddOns);

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

                Row(
                  children: [
                    Container(
                      height: h * 0.04,
                      width: w * 0.3,
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
                      child: Row(
                        children: [
                          SizedBox(width: w * 0.03,),
                          SvgPicture.asset('assets/icons/share_black.svg'),
                          SizedBox(width: w * 0.02,),
                          Center(
                            child: Text('Share Order',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize12,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: w * 0.02,),
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
                    ),
                  ],
                )
              ],
            ),
          ),

          Positioned(
            bottom: _isExpanded ? 0 : h * 0.37,
            child: Padding(
              padding: EdgeInsets.only(left: w * 0.04),
              child: Container(
                // height: h * 0.34,
                width: w * 0.92,
                constraints: BoxConstraints(
                  minHeight: _isExpanded ? h * 0.83 : h * 0.34,
                  maxHeight: _isExpanded ? h * 0.83 : h * 0.34,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color(0xFFE09B2D),
                    width: 1
                  )
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(

                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.015),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _isExpanded = false;
                                        });
                                      },
                                        child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                                    ),
                                    SizedBox(height: h * 0.02,),
                                    Text('Requests',
                                      style: TextStyle(
                                        fontSize: fontSizes.fontSize24,
                                        fontFamily: 'Supreme_bold',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                      ),
                                    ),
                                    SizedBox(height: h * 0.02,),
                                    Container(
                                      constraints: BoxConstraints(
                                        minHeight: !_isExpanded ? h * 0.11 : 0.5, // Minimum height when closed
                                        maxHeight: _isExpanded ? h * 0.5 : h * 0.11, // Maximum height when open
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300), // Smooth transition
                                        child: ListView.builder(
                                          itemCount: 9,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics: _isExpanded
                                              ? NeverScrollableScrollPhysics() // Scrollable when open
                                              : NeverScrollableScrollPhysics(), // No scrolling when closed
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isRequestOpen = true; // Toggle state
                                                });
                                              },
                                              child: _buildRequestItems(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),


                                    // SizedBox(height: h * 0.01,),
                                    Text('Click on any of the request to see the items',
                                      style: TextStyle(
                                        fontSize: fontSizes.fontSize12,
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF606060),
                                      ),
                                    ),
                                  ],
                                ),
                              ),





                              AnimatedSize(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                                child: Visibility(
                                  visible: _isExpanded,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: h * 0.02,),
                                        Container(
                                          width: w,
                                          height: h * 0.01,
                                          color: Color(0xFFF1F1F1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Total Order Details',
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
                                              Text('Restaurant Details',
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





                            ],
                          ),
                        ],
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              )
                            ),
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
                                        _isExpanded ? 'View less details' : 'View more details',
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
            ),
          ),


          Visibility(
            visible: !_isExpanded,
            child: DraggableScrollableSheet(
                initialChildSize: 0.35,
                minChildSize: 0.35,
                maxChildSize: 0.85,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)
                        )
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: h * 0.02,),
                          Container(
                            width: w * 0.35,
                            height: h * 0.005,
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                              // color: Colors.black
                            ),
                          ),
                          SizedBox(height: h * 0.03,),
                          Column(
                            children: [

                              Padding(
                                padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Add more to the table',
                                      style: TextStyle(
                                          fontFamily: 'Supreme_bold',
                                          fontWeight: FontWeight.w700,
                                          fontSize: fontSizes.fontSize24,
                                          color: Colors.black
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: h * 0.005,
                                          width: w * 0.01,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF606060),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: w * 0.02,),
                                        Text('Serving on the Table 32',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize14,
                                              color: Color(0xFF606060)
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: h * 0.03,),

                                    Container(
                                      height: h * 0.0285,
                                      width: w,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.002),
                                            child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                              width: w * 0.02,
                                              height: h * 0.025,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.04,),
                                          Container(
                                            height: h * 0.0285,
                                            width: w * 0.005,
                                            color: Color(0xFF606060),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Flexible(
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: productAddOnsList.length,
                                                itemBuilder: (context, index){
                                                  TextStyle textStyle = TextStyle(
                                                    fontSize: fontSizes.fontSize15,
                                                    fontFamily: 'Poppins_semi_bold',
                                                    fontWeight: FontWeight.w700,
                                                    color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                                  );

                                                  // Calculate text width dynamically
                                                  double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);

                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedMonthIndex = index; // Update the selected month index
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Container(
                                                        margin: EdgeInsets.zero, // Ensure no margin is applied
                                                        padding: EdgeInsets.zero,
                                                        child: Center(

                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                productAddOnsList[index],
                                                                style: TextStyle(
                                                                    fontSize: fontSizes.fontSize14,
                                                                    fontFamily: 'Poppins_semi_bold',
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.black
                                                                ),
                                                              ),
                                                              Container(
                                                                height: h * 0.003,
                                                                width: textWidth + w * 0.02,
                                                                decoration: BoxDecoration(
                                                                  color: selectedMonthIndex == index
                                                                      ? Color(0xFF000000) // Highlight selected month
                                                                      : Colors.transparent, // No background for unselected months
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius.circular(10),
                                                                      topLeft: Radius.circular(10)
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    ListView.builder(
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: h * 0.03),
                                              child: Text(
                                                'Starter',
                                                style: TextStyle(
                                                  fontSize: fontSizes.fontSize24,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Supreme_bold',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: h * 0.02),
                                              child: Column(
                                                // Wrap with Column to avoid Expanded misplacement
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: 4,
                                                    itemBuilder: (BuildContext context, int rowIndex) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            // Implement your onTap functionality here
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                                          child: _buildItems(context),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                )


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







          Positioned(
              bottom: h * 0.02,
              child: Visibility(
                visible: isRequestOpen,
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
                                          isRequestOpen = false;

                                        });
                                      },
                                      child: SvgPicture.asset('assets/icons/left_arrow_grey_bg.svg')
                                  ),
                                  SizedBox(height: h * 0.02,),
                                  
                                  Text('Cooking',
                                    style: TextStyle(
                                      fontSize: fontSizes.fontSize24,
                                      fontFamily: 'Supreme_bold',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                    ),
                                  ),

                                  Text('Request 2',
                                    style: TextStyle(
                                        fontSize: fontSizes.fontSize12,
                                        fontFamily: 'Poppins_regular',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF606060)
                                    ),
                                  ),

                                  SizedBox(height: h * 0.02,),
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/preparing_order_enable.svg'),
                                      Container(
                                        height: h * 0.005,
                                        width: w * 0.25,
                                        color: Colors.black,
                                      ),

                                      SvgPicture.asset('assets/icons/on_the_table_disable.svg'),
                                    ],
                                  ),

                                  SizedBox(height: h * 0.02,),

                                  Text('Order will be placed at the scheduled date & time.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize12,
                                        fontFamily: 'Poppins_regular',
                                        color: Color(0xFF606060)
                                    ),
                                  ),
                                  // SizedBox(height: h * 0.02,),


                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.02,),
                            Container(
                              width: w,
                              height: h * 0.01,
                              color: Color(0xFFF1F1F1),
                            ),
                            SizedBox(height: h * 0.02,),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Poppins_semi_bold',
                                        color: Colors.black
                                    ),
                                  ),
                                  Text('1x Cheese Pizza',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize12,
                                        fontFamily: 'Poppins_regular',
                                        color: Color(0xFF606060)
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
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
                                ],
                              ),
                            )

                          ],
                        ),


                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(isRequestOpen){
                                    isRequestOpen = false;
                                  }else {
                                    isRequestOpen = true;
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
                                            isRequestOpen ? 'View less details' : 'View all details',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset(
                                              isRequestOpen ? 'assets/icons/up_arrow_black.svg' : 'assets/icons/down_arrow_black.svg'
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

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  Widget _buildRequestItems(){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      width: w,
      child: Column(
        children: [
          SizedBox(height: h * 0.015,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/coocking_yellow.svg'),
                  SizedBox(width: w * 0.02,),
                  Text('R2 - On the Table (x1)',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_semi_bold',
                        fontSize: fontSizes.fontSize16,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
              SvgPicture.asset('assets/icons/arrow_right_black_big.svg'),

            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.138,
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
                  Text('Cheese Pizza',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_bold'
                    ),
                  ),
                  Text('Corn, Mozzarella Cheese, Mint Mayonnaise',
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

List<String> categories = [
  'Drink',
  'Fast Food',
  'Ice Cream',
  'Desert',
  'North Indian',
  'South Indian',
  'Snacks',
  'Healthy',
  'Breakfast',
];

List<String> productAddOns = [
  'Base',
  'Add-ons',
  'Sprinklers',
  'Preferences',
];
