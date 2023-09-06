import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weatherapp/Api_Interface/Api_Interface.dart';

import 'Controller/CommonController.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/Splash_Screen.dart';
import 'app_utlis/Text_utlis.dart';
import 'app_utlis/colors_utlis.dart';

void main() {

  Get.put(CommonController(), permanent: false);
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}



