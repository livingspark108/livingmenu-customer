import 'dart:async';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:living_menu_mobile/Cart/addNewAddress.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';

import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';

// import 'package:livingmenuapp/Yourcart.dart';
// import 'package:livingmenuapp/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


class CartSelectAddress extends StatefulWidget {
  CartSelectAddress({Key? key, required this.latLong}) : super(key: key);

  // const MapScreen({super.key});

  LatLng latLong;

  @override
  State<CartSelectAddress> createState() => CartSelectAddressState();
}

class CartSelectAddressState extends State<CartSelectAddress> {
  late GoogleMapController mapController;
  late LatLng _userLatLong;
  late LatLng _userSelectedLatLong;
  late String lat;
  late String long;
  Position? _currentPosition;
  Uint8List? markerImage;
  late double h, w;
  String address = '';
  String area_name = '';
  String localArea = '';
  String city = '';
  String state = '';
  String pinCode = '';
  String countryName = '';
  String fullAddresses = '';
  String tokenForSession = '37465';
  var uuid = Uuid();
  List<dynamic> listForPlaces = [];
  String apiKey = AppStrings.MAP_API_KEY;
  final TextEditingController _textController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    // requestPermission();
    // getLocation();
    _userLatLong = widget.latLong;
    _userSelectedLatLong = _userLatLong;
    // _getAddressFromLatLng(_userLatLong);
    _getAddressFromLatLng(_userLatLong);
    // placeAutoComplete("jhalawar");
    super.initState();
    _textController.addListener(() {
      onModify();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void makeSuggestion(String input) async{
    String groundUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$groundUrl?input=$input&key=$apiKey&sessiontoken=$tokenForSession';

    var responseResult = await http.get(Uri.parse(request));
    var resultData = responseResult.body.toString();
    print('result Data');
    print(resultData);
    if(responseResult.statusCode == 200){
      setState(() {
        listForPlaces = jsonDecode(responseResult.body.toString()) ['predictions'];
      });
    }else {
      throw Exception('Something went wrong, Please try again');
    }
  }

  void onModify(){
    if(tokenForSession == null){
      setState(() {
        tokenForSession = uuid.v4();
      });
    }
    makeSuggestion(_textController.text);
  }

  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    final apiKey = AppStrings.MAP_API_KEY;
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];
      extractAddress(results);
      // print('DATA: $results');
      if (results.isNotEmpty) {
        final addressComponents = results[0]['address_components'];
        setState(() {
          address = addressComponents
              .map((component) => component['long_name'])
              .join(', ');
          // print('Address: $address');
        });
      }
    } else {
      print('Failed to load address');
    }
  }

  void extractAddress(dynamic json) {
    // Check if the data is a list of address components
    if (json is List) {
      for (var item in json) {
        if (item is Map<String, dynamic> &&
            item.containsKey('address_components')) {
          List<dynamic> components = item['address_components'];

          String premise = '';
          String neighborhood = '';
          String sublocality = '';
          String locality = '';
          String postalCode = '';
          String administrativeArea = '';
          String country = '';

          // Loop through the address components and find specific types
          components.forEach((component) {
            List<dynamic> types = component['types'];

            if (types.contains('premise')) {
              premise = component['long_name'];
            } else if (types.contains('neighborhood')) {
              neighborhood = component['long_name'];
              area_name = neighborhood;
            } else if (types.contains('sublocality') ||
                types.contains('sublocality_level_1')) {
              sublocality = component['long_name'];
              localArea = sublocality;
            } else if (types.contains('locality')) {
              locality = component['long_name'];
              city = locality;
            } else if (types.contains('postal_code')) {
              postalCode = component['long_name'];
              pinCode = postalCode;
            } else if (types.contains('administrative_area_level_1')) {
              administrativeArea = component['long_name'];
              state = administrativeArea;
            } else if (types.contains('country')) {
              country = component['long_name'];
              countryName = country;
            }
          });

          print('Premise: $premise');
          print('Neighborhood: $neighborhood');
          print('Sublocality: $sublocality');
          print('Locality: $locality');
          print('Postal Code: $postalCode');
          print('Administrative Area: $administrativeArea');
          print('Country: $country');

          // Combine fields if needed
          String fullAddress =
              '$sublocality, $locality, $administrativeArea, $country, $postalCode';
          fullAddresses = fullAddress;
          print('Full Address: $fullAddress');
        }
      }
    } else {
      print("The provided JSON is not a list.");
    }
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getCurrentLocation() async {
    // LocationPermission permission;
    // permission = await Geolocator.requestPermission();

    await Permission.locationWhenInUse.isDenied.then((value) {
      if (value) {
        Permission.locationWhenInUse.request();
      }
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentPosition = position;

    LatLng userLatLong =
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    _userLatLong = userLatLong;
    CameraPosition _cameraPosition =
        CameraPosition(target: userLatLong, zoom: 15);
    mapController!
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }


  @override
  Widget build(BuildContext context) {
    // _userLatLong = LatLng(37.42796133580664, -122.085749655962);
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    _userLatLong = widget.latLong;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.25, bottom: h * 0.142),
                child: GoogleMap(
                  // onMapCreated: _onMapCreated,
                  mapType: MapType.terrain,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  // markers: <Marker>{_setMarker()},
                  initialCameraPosition:
                      CameraPosition(target: _userLatLong, zoom: 15),
                  onMapCreated: (GoogleMapController controllerMap) {
                    mapController = controllerMap;
                    _controller.complete(mapController);
                    getCurrentLocation();
                  },
                  onCameraMove: (CameraPosition position) {
                    // This gets called every time the map is moved.
                    setState(() {
                      lat = position.target.latitude.toString();
                      long = position.target.longitude.toString();
                      print("Camera moved at: Lat: $lat, Long: $long");
                    });
                  },
                  onCameraIdle: () async {
                    // This gets called when the camera movement stops.
                    LatLng currentLatLng = await mapController
                        .getLatLng(ScreenCoordinate(x: w ~/ 2, y: h ~/ 2));
                    _getAddressFromLatLng(currentLatLng);
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
            Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: h * 0.25,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.05, left: w * 0.015),
                          child: Row(
                            children: [
                              IconButton(
                                icon:
                                    SvgPicture.asset('assets/icons/header_back.svg'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Yourcart()));*/
                                },
                              ),
                              Text(
                                'Choose delivery location',
                                style: TextStyle(
                                    fontFamily: 'Supreme_bold',
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSizes.fontSize24,
                                    color: Colors.black
                                    // fontSize: 18
                                    ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w * 0.04, right: w * 0.04, top: h * 0.01),
                          child: Stack(
                            children: [
                              Container(
                                height: h * 0.05,
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.only(left: w * 0.1, bottom: h * 0.005),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFF1F1F1),
                                  // color: Colors.red,
                                ),
                                child: TextFormField(
                                  controller: _textController,
                                  cursorColor: Colors.red,
                                  decoration: InputDecoration(
                                    // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Search for Addresses',
                                    labelStyle: TextStyle(
                                      // Custom style for the label
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Color(0xFF606060), // Label color
                                    ),
                                    hintText: 'Search for Addresses',
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins_regular',
                                      color: Color(0xFF606060), // Hint text color
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF1F1F1),
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ).copyWith(isDense: true),
                                ),
                              ),
                              Positioned(
                                  top: h * 0.012,
                                  left: w * 0.03,
                                  child: SvgPicture.asset(
                                      'assets/icons/search_gray.svg')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.025),
                          child: GestureDetector(
                            onTap: () async{
                              await getCurrentLocation();
                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(_userLatLong.latitude, _userLatLong.longitude),
                                    zoom: 15, // Set the zoom level as needed
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/current_location_icon.svg'),
                                    SizedBox(width: w * 0.02,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Use current location',
                                          style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontSize: fontSizes.fontSize14,
                                            fontWeight: ui.FontWeight.w500,
                                            color: Colors.black,
                                            height: 1
                                          ),
                                        ),
                                        Text('Enable location services',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: ui.FontWeight.w500,
                                              color: Color(0xFF606060),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SvgPicture.asset('assets/icons/right_arrow.svg')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: listForPlaces.length > 0 ? h * 0.6 : 0.0,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: listForPlaces.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: () async {
                              print("Tapped on: ${listForPlaces[index]['description']}");
                              try {
                                // Get the location from the address
                                List<Location> location = await locationFromAddress(listForPlaces[index]['description']);
                                if (location.isNotEmpty) {
                                  _textController.clear();
                                  double latitude = location.last.latitude;
                                  double longitude = location.last.longitude;
                                  print("Latitude: $latitude");
                                  print("Longitude: $longitude");
                                  _userSelectedLatLong = LatLng(latitude, longitude);
                                  _getAddressFromLatLng(_userSelectedLatLong);
                                  print('USER_LAT_LONG: ${_userSelectedLatLong}');

                                  // Move the camera to the selected location
                                  mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(latitude, longitude),
                                        zoom: 15, // Set the zoom level as needed
                                      ),
                                    ),
                                  );

                                } else {
                                  print("No locations found for ${listForPlaces[index]['description']}");
                                }
                              } catch (e) {
                                print("Error fetching location: $e");
                              }

                            },
                            child: ListTile(
                              title: Text(listForPlaces[index]['description']),
                            ),
                          );
                        }
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
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: h * 0.02, left: w * 0.05, bottom: h * 0.02),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/home_black.svg',
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.035),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$area_name',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans_bold',
                                      fontWeight: FontWeight.w800,
                                      fontSize: w * 0.041,
                                      height: 1,
                                      color: Colors.black
                                      // fontSize: 17
                                      ),
                                ),
                                Text(
                                  '$localArea, $city',
                                  style: TextStyle(
                                      fontFamily: 'DM_Sans_regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: w * 0.034,
                                      height: 1,
                                      color: Colors.black
                                      // fontSize: 14
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, bottom: h * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          print('USER_LAT_LONG_ON_UPDATE: ${_userSelectedLatLong}');
                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(AddNewAddress(latLong: _userSelectedLatLong, state: state, city: city, pinCode: pinCode, areaName: area_name, localArea: localArea, country: countryName,)));
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
                              'Update',
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
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  _setMarker() {
    //async{
    // final Uint8List markerIcon = await getBytesFromAsset('assets/marker.png', 100);
    // return Marker(markerId: MarkerId("current_location"), icon: BitmapDescriptor.fromBytes(markerIcon));
    /*return Marker(markerId: MarkerId("current_location"), icon: await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/marker.png',
    ),*/
    // position: target.target,
    // rotation: target.tilt,
    // final Uint8List markerIcon = await getBytesFromAsset('asseta/marker.png', 100);
    return Marker(
        markerId: MarkerId('1'),
        position: _userLatLong,
        icon: BitmapDescriptor.defaultMarker,
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            _userLatLong = newPosition; // Update marker position
            lat = newPosition.latitude.toString(); // Store new latitude
            long = newPosition.longitude.toString(); // Store new longitude
          });
        });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

//--------------------
}
