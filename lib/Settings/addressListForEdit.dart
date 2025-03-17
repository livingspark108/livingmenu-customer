import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Cart/cartOrderPlace.dart';
import 'package:living_menu_mobile/Cart/cartSelectAddress.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Models/addressModel.dart';
import 'package:living_menu_mobile/Settings/editAddress.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../CustomItems/customCircularProgressIndicator.dart';

class AddressListForEdit extends StatefulWidget {
  const AddressListForEdit({Key? key}) : super(key: key);

  @override
  State<AddressListForEdit> createState() => _AddressListForEditState();
}

class _AddressListForEditState extends State<AddressListForEdit>{
  late double w, h;
  late LatLng _userLatLong;
  Position? _currentPosition;
  String selectedLocation = '';
  bool _isLoading = true;
  ApiService apiService = ApiService();
  List<AddressModel>? addressModel;


  void updateSelectedLocation(String location) {
    setState(() {
      selectedLocation = location;
    });
  }

  getCurrentLocation() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // await Future.delayed(Duration(seconds: 10));
    // await Future.delayed(Duration(milliseconds: 100));
    // Request location permission
    if (await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }

    // await Future.delayed(Duration(seconds: 10));
    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;

      // Set the user latitude and longitude
      _userLatLong = LatLng(
          _currentPosition!.latitude, _currentPosition!.longitude);

      _isLoading = false; // Hide loading indicator after location is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    apiService.getAddresses().then((value) {
      setState(() {
        addressModel = value;

        print('Address---------------: ${addressModel}');
        // print('ID------------>: ${addressModel![0].id}');
        // print('ProductMessage---------------: ${productCategory.message}');
        _isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              'Addresses',
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
              SizedBox(height: h * 0.02,),
              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                child: GestureDetector(
                  onTap: ()async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isComeFromAddressBook', false);
                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(CartSelectAddress(latLong: _userLatLong)));
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF1F1F1)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: w * 0.04,),
                        SvgPicture.asset('assets/icons/add_grey.svg'),
                        SizedBox(width: w * 0.03,),
                        Text(
                          'Add New Address',
                          style: TextStyle(
                              fontFamily: 'Poppins_regular',
                              fontWeight: FontWeight.w500,
                              fontSize: fontSizes.fontSize14,
                              color: Color(0xFF606060)
                            // fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.025,),
              Padding(
                padding: EdgeInsets.only(left: w * 0.04),
                child: Text(
                  'Saved Addresses',
                  style: TextStyle(
                      fontFamily: 'Poppins_semi_bold',
                      fontWeight: FontWeight.w600,
                      fontSize: fontSizes.fontSize16,
                      color: Colors.black
                    // fontSize: 18
                  ),
                ),
              ),
              SizedBox(height: h * 0.025,),

              _isLoading ? Container() : Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: addressModel!.length > 0
                      ? ListView.builder(
                      itemCount: addressModel!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index){
                        if (addressModel == null || addressModel!.isEmpty) {
                          return SizedBox.shrink(); // Return an empty widget if no items
                        }else {
                          // return _buildAddressItem();
                          AddressModel addressM = addressModel![index];
                          LatLng latLng = LatLng(double.parse(addressM.lat ?? '0.0'), double.parse(addressM.long ?? '0.0'));
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  AnimatedRoute.createRouteRightToLeft(
                                      EditAddress(latLong: latLng, floor: addressM.floor ?? '',
                                          entryCode: addressM.entryCode ?? '', buildingName: addressM.houseNo ?? '',
                                          fullAddress: addressM.fullAddress ?? '', mobileNo: addressM.mobileNo ?? '',
                                          landmark: addressM.landmark ?? '', state: addressM.state ?? '', city: addressM.city ?? '',
                                          pinCode: addressM.pincode ?? '', dropOff: addressM.dropOffOptions ?? '',
                                          deliveryInstruction: addressM.deliveryInstruction ?? '',
                                          addressLabel: addressM.type ?? '', isGift: addressM.giftOptions ?? false,
                                          country: addressM.country ?? '', areaName: addressM.area ?? '', addressId: addressM.id ?? '',)));
                            },

                            child: _buildAddressItem(addressM),
                          );
                        }

                      }
                  ) : Center(
                    child: Text('No addresses found.'),
                  ),
                ),
              )

              /*_isLoading ? Container() : Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: ListView.builder(
                      itemCount: 4,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index){
                        // return _buildAddressItem();
                        AddressModel addressM = addressModel![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(EditAddress(latLong: _userLatLong)));
                          },

                          child: _buildAddressItem(addressM),
                        );
                      }
                  ),
                ),
              )*/



            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(AddressModel addressM){
    AppFontSizes fontSizes = AppFontSizes(context);

    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: h * 0.015, bottom: h * 0.01),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/icons/default_address_icon.svg'),
                SizedBox(width: w * 0.03,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // 'MIG F-2/9, Jawahar nagar, nanakhed, Malviya nagar, japiur',
                        addressM.fullAddress ?? '',
                        style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize14,
                            color: Colors.black,
                            height: 1
                          // fontSize: 18
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${addressM.city} ${addressM.pincode}',
                        style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontWeight: FontWeight.w500,
                          fontSize: fontSizes.fontSize12,
                          color: Color(0xFF606060),
                          // height: 1
                          // fontSize: 18
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: h * 0.005,),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.005, bottom: h * 0.005),
                              child: Text(
                                addressM.type ?? '',
                                style: TextStyle(
                                  fontFamily: 'Supreme_bold',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize10,
                                  color: Colors.black,
                                  // height: 1
                                  // fontSize: 18
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          Visibility(
                            visible: addressM.isDefault ?? false,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF001FFF),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02, top: h * 0.005, bottom: h * 0.005),
                                child: Text(
                                  'Default',
                                  style: TextStyle(
                                    fontFamily: 'Supreme_bold',
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize10,
                                    color: Colors.white,
                                    // height: 1
                                    // fontSize: 18
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: w * 0.05,),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.025),
                  child: SvgPicture.asset('assets/icons/right_arrow.svg'),
                ),
              ],
            ),
            SizedBox(height: h * 0.015,),
            Container(
              height: h * 0.001,
              width: w,
              color: Color(0xFFF1F1F1),
            )
          ],
        ),
      ),
    );
  }

}
