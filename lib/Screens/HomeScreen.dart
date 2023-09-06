import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api_Interface/Api_Interface.dart';
import '../Controller/CommonController.dart';
import '../app_utlis/Text_utlis.dart';
import '../app_utlis/colors_utlis.dart';

class Homepage extends StatelessWidget {
   Homepage({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  RxBool isLoading = false.obs;

  String selectedLocation = '';

  CommonController commonController = Get.find<CommonController>();

  var textediting = Text_utlis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorUtils.primaryColor.withOpacity(0.7),
        centerTitle: true,
        elevation: 5,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Light grey background color
                      borderRadius:
                          BorderRadius.circular(30.0), // Rounded corners
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textController,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            labelText: 'Search',
                            border: InputBorder.none, // Remove the border
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ), // Add the search icon
                            suffixIcon: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _textController.clear();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => SizedBox(
                      height: Get.height * 0.065,
                      width: Get.width * 0.3,
                      child: ElevatedButton(
                        onPressed: () async {
                          isLoading.value = true;
                          await Api_Interface()
                              .Search_Weather(_textController.text.toString());
                          isLoading.value = false;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                        ),
                        child: isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => textediting.medium20(25.0, commonController.weather_location.value.location?.name ??'Search Your Location',
                      ColorUtils.whiteColor.withOpacity(0.9),
                      TextAlign.center)),
                ],
              )),
        ),
        title: textediting.medium20(25.0, "Weather App",
            ColorUtils.whiteColor.withOpacity(0.9), TextAlign.center),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/day/cloud_image2.jpg'),
              // Replace with your image path
              fit: BoxFit.cover, // Cover the entire container
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => SizedBox(
                  height: Get.height * 0.6652,
                  width: Get.width,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: commonController.weather_location.value
                              .forecast?.forecastday!.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: Get.height * 0.25,
                              width: Get.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: commonController
                                      .weather_location
                                      .value
                                      .forecast
                                      ?.forecastday![index]
                                      .hour!
                                      .length,
                                  itemBuilder: (context, indexx) {
                                    String apiResponse =
                                        "${commonController.weather_location.value.forecast?.forecastday![index].hour![indexx].condition?.icon}";

                                    List<String> parts = apiResponse.split('/');

                                    String day = parts.last.toString();
                                    String code =
                                        parts[5].replaceAll(".png", "");

                                    return Column(
                                      children: [
                                        textediting.medium20(
                                            16.0,
                                            "${commonController.weather_location.value.forecast?.forecastday![index].hour![indexx].time}",
                                            ColorUtils.whiteColor,
                                            TextAlign.center),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          color: ColorUtils.primaryColor
                                              .withOpacity(0.7),
                                          child: SizedBox(
                                            height: 100,
                                            width: 150,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    'assets/images/$code/$day')
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          color: ColorUtils.primaryColor
                                              .withOpacity(0.7),
                                          child: SizedBox(
                                            height: 49,
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                textediting.medium20(
                                                    16.0,
                                                    "temp_c:          ${commonController.weather_location.value.forecast?.forecastday![index].hour![indexx].tempC}",
                                                    ColorUtils.whiteColor
                                                        .withOpacity(0.9),
                                                    TextAlign.center),
                                                textediting.medium20(
                                                    16.0,
                                                    "temp_f:          ${commonController.weather_location.value.forecast?.forecastday![index].hour![indexx].tempF}",
                                                    ColorUtils.whiteColor
                                                        .withOpacity(0.9),
                                                    TextAlign.center),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
