import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants/appFontSizes.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage>{
  late double w, h;
  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: h * 0.2,),
            Text('Oops...',
              style: TextStyle(
                fontSize: fontSizes.fontSize40,
                fontFamily: 'Archivo_bold',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: h * 0.03,),
            Text('Nothing Here',
              style: TextStyle(
                fontSize: fontSizes.fontSize60,
                fontFamily: 'Archivo_bold',
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1
              ),
              textAlign: TextAlign.center,
            ),
            SvgPicture.asset('assets/icons/error_img.svg')
          ],
        ),
      ),
    );
  }

}
