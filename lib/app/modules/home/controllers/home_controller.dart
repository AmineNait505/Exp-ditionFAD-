import 'package:fadprod/app/data/models/Chargement.dart';
import 'package:fadprod/app/services/chargementServices.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ChargementServices chargementServices = ChargementServices();
  var chargements = <Chargement>[].obs;
  var selectedOption = ''.obs;
  var loading = true.obs; // Loading state
  var error =''.obs;

  @override
  void onInit() {
    super.onInit();
    getChargementOpen();
  }

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }

   Future<void> getChargementOpen() async {
    try {
      loading.value = true;
      error.value = ''; // Clear previous error message
      final response = await chargementServices.getChargementOpen("0");
      if (response.chargements.isEmpty) {
        error.value = 'No data available';
      } else {
        chargements.value = response.chargements;
      }
    } catch (e) {
      String errorMessage = e is Exception ? e.toString() : 'An unknown error occurred';
      if (errorMessage.contains('Problème de connexion')) {
        error.value = 'Problème de connexion';
      } else {
        error.value = errorMessage;
      }
    } finally {
      loading.value = false;
    }
  }
}
