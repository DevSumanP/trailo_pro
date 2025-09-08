import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceUtils {

  static double getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  } 

  static double getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  } 

  static double getStatusBarHeight(BuildContext context){
    return MediaQuery.of(context).padding.top;
  }

  static double getAppBarHeight(){
    return kToolbarHeight;
  }

  static double getBottomNavigationBarHeight(){
    return kBottomNavigationBarHeight;
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color? color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
  }

  static Future<void> setBottomNavBarColor(Color? color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,);
  }
}