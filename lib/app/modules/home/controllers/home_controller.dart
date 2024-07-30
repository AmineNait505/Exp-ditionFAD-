import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedOption = ''.obs;

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }
}
