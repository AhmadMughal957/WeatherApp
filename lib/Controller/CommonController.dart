import 'package:get/get.dart';

import '../models/Weather_models.dart';

class CommonController{
  Rx<Weather_Location_model> weather_location=Weather_Location_model().obs;
  RxString Response=''.obs;
}