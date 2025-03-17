import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';

class CustomPopup extends StatelessWidget {

  final String title;
  final String message;
  final String cancelButtonName;
  final String confirmButtonName;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final double cancelLeftRightPadding;


  const CustomPopup({
    Key? key,
    required this.title,
    required this.message,
    required this.cancelButtonName,
    required this.confirmButtonName,
    required this.confirmColor,
    required this.onConfirm,
    required this.cancelLeftRightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    double w, h;
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: fontSizes.fontSize24,
                      fontWeight: FontWeight.w700,
                    fontFamily: 'Supreme_bold'
                  )),
              // SizedBox(height: 10),
              Text(message,
                  style: TextStyle(
                      fontSize: fontSizes.fontSize14,
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF939393)
                  )),
              SizedBox(height: 20),
              Container(
                width: w,
                height: h * 0.001,
                color: Color(0xFFF1F1F1),
              ),
              SizedBox(height: h * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: cancelLeftRightPadding, right: cancelLeftRightPadding, top: h * 0.01, bottom: h * 0.01),
                        child: Text(cancelButtonName,

                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins_semi_bold',
                              fontSize: fontSizes.fontSize16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: w * 0.06,),
                  GestureDetector(
                    onTap: (){
                      onConfirm();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color(0xFF001FFF),
                        color: confirmColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.1, right: w * 0.1, top: h * 0.01, bottom: h * 0.01),
                        child: Text(confirmButtonName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins_semi_bold',
                            fontSize: fontSizes.fontSize16,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
