import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import '../Constants/appFontSizes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TableScanner extends StatefulWidget {
  const TableScanner({Key? key}) : super(key: key);

  @override
  State<TableScanner> createState() => _TableScannerState();
}

class _TableScannerState extends State<TableScanner> {
  late double w, h;
  late Timer _timer;
  String _dots = "";
  MobileScannerController controller = MobileScannerController();

  /*String barcode = "No Barcode Scanned";

  Future<void> startBarcodeScan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", // Line color
        "Cancel", // Cancel button text
        true, // Whether to show the flash icon
        ScanMode.BARCODE, // Can also be ScanMode.QR
      );
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the scan is not canceled
    if (!mounted) return;

    setState(() {
      barcode = barcodeScanRes;
    });
  }*/

  void _startDotAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _dots = (_dots.length < 3) ? _dots + "." : "";
      });
    });
  }

  Future<void> setDineIn () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDineIn', true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDineIn();
    _startDotAnimation();
    Timer(Duration(seconds: 5), () {
      // Navigate to the next screen
      Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(MainScreen()), (route) => false);
    });
    // startBarcodeScan();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    // TODO: implement build
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFDC8800), // Start color
              Color(0xFFF45601),
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.04),
                  child: Container(
                    width: w,
                    height: h * 0.48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)
                      )
                    ),
                    child: MobileScanner(
                      controller: controller,
                      onDetect: (BarcodeCapture barcode) {
                        if (barcode.barcodes.isNotEmpty) {
                          final String? code = barcode.barcodes.first.rawValue; // Getting the first detected barcode
                          if (code != null) {
                            debugPrint('Barcode found! $code');
                            // Handle barcode result here
                          } else {
                            debugPrint('No code found in the detected barcode');
                          }
                        } else {
                          debugPrint('No barcode detected');
                        }
                      },
                      /*onDetect: (barcode, args) {
                        final String? code = barcode.rawValue;
                        debugPrint('Barcode found! $code');
                        // Handle barcode result here
                      },*/
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: h * 0.1),
                    child: Text('Scanning$_dots',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize24,
                        fontFamily: 'Supreme_bold',
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.08),
                  child: Container(
                    height: h * 0.4,
                    child: Image.asset('assets/images/qr_scanner_box.png',
                      height: h * 0.4,
                      width: w,
                    ),
                  ),
                ),
                Positioned(
                  bottom: h * 0.05,
                    right: w * 0.1,
                    child: SvgPicture.asset('assets/icons/qr_code_white.svg')
                ),

              ],
            ),

            Stack(
              children: [
                Image.asset('assets/images/dinein_round_bg.png',),
                Positioned(
                  top: h * 0.2,
                  left: w * 0.28,
                  child: Container(
                    width: w * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Dine In',
                          style: TextStyle(
                              fontFamily: 'Archivo_bold',
                              fontWeight: FontWeight.w400,
                              fontSize: fontSizes.fontSize40,
                              color: Colors.white
                            // fontSize: fontSizes.fontSize36
                          ),
                        ),
                       /* Text('Get special discounts, and vouchers with our app',
                          style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            fontSize: fontSizes.fontSize12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),*/
                      ],
                    ),
                  ),
                ),

                Positioned(
                    bottom: h * 0.07,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05),
                          child: Container(
                            width: w * 0.9,
                            height: h * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Positioned(
                  // bottom: -25,
                    bottom: h * 0.04,
                    left: w * 0.025,
                    child: Image.asset(
                      'assets/images/dinein_save.png',
                      width: w * 0.3,
                    )
                ),
                Positioned(
                    bottom: h * 0.08,
                    // bottom: -(h * 0.03),
                    left: w * 0.26,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Save over ₹100 on app wallet',
                          style: TextStyle(
                              fontSize: fontSizes.fontSize14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Colors.white
                          ),
                        ),
                        Text('with minimum order of ₹800',
                          style: TextStyle(
                              fontSize: fontSizes.fontSize12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins_regular',
                              color: Colors.white
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )
            // startBarcodeScan,
          ],
        ),
      ),
    );
  }

}
