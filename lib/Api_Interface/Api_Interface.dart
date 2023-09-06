import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Controller/CommonController.dart';
import '../models/Weather_models.dart';

class Api_Interface {
  CommonController commonController = Get.find<CommonController>();

  Future<int> Search_Weather(
    String Location,
  ) async {
    final response = await http.get(
      Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=7eb68f76325f4410b6073429230609&q=${Location}&days=5&aqi=no&alerts=no"),
    );
    if (response.statusCode == 400) {

      commonController.weather_location.value = Weather_Location_model(

      );
    }
    else if (response.statusCode == 200) {

      print(response.statusCode);
      commonController.weather_location.value = Weather_Location_model.fromJson(jsonDecode(response.body));
    }

    return response.statusCode;
  }
}
