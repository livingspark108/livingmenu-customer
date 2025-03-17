import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';

class DottedBorderContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double screenWidth;
  final double screenHeight;

  const DottedBorderContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.screenWidth,
    required this.screenHeight,
    this.borderRadius = 12, // Default radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppFontSizes fontSizes = AppFontSizes(context);
    return CustomPaint(
      size: Size(width, height),
      painter: DottedBorderPainter(borderRadius: borderRadius),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight * 0.01, bottom: screenHeight * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/apply_coupon_blue.svg'),
                  SizedBox(width: screenWidth * 0.03,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('20% off, up to ₹50',
                        style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontFamily: 'Poppins_regular',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF001FFF)
                        ),
                      ),
                      Text('Add ₹300 to apply deal',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontFamily: 'Poppins_regular',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF606060)
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SvgPicture.asset('assets/icons/close_red.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final double borderRadius;

  DottedBorderPainter({this.borderRadius = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF001FFF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final PathMetrics pathMetrics = path.computeMetrics();
    for (final PathMetric metric in pathMetrics) {
      double distance = 0;
      const double dashWidth = 4;
      const double dashSpace = 4;

      while (distance < metric.length) {
        final Tangent? tangent = metric.getTangentForOffset(distance);
        if (tangent != null) {
          canvas.drawLine(
            tangent.position,
            metric.getTangentForOffset(distance + dashWidth)?.position ?? tangent.position,
            paint,
          );
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}