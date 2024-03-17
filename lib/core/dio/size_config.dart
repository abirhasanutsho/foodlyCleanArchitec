import 'dart:io';

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }

}



double getProportionateScreenHeight(double inputHeight) {
  // if(inputHeight.isFinite==300){
  //
  // }
  double screenHeight = SizeConfig.screenHeight!;
  return Platform.isAndroid
      ? (inputHeight / 812.0) * screenHeight
      : inputHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  return Platform.isAndroid ? (inputWidth / 375.0) * screenWidth : inputWidth;
}

int getProportionateScreenHeightInt(int inputHeight) {
  int screenHeight = SizeConfig.screenHeight!.toInt();
  return Platform.isAndroid
      ? ((inputHeight / 812.0) * screenHeight).toInt()
      : inputHeight.toInt();
}

int getProportionateScreenWidthInt(int inputWidth) {
  int screenWidth = SizeConfig.screenWidth!.toInt();
  return Platform.isAndroid
      ? ((inputWidth / 375.0) * screenWidth).toInt()
      : inputWidth.toInt();
}
