import 'package:get/get.dart';

class LocationController extends GetxController {
  RxDouble latitude = RxDouble(0.0);
  RxDouble longitude = RxDouble(0.0);

  void setLocation({required double lat, required double lng}) {
    latitude.value = lat;
    longitude.value = lng;
  }
}
