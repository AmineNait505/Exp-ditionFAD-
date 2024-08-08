import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:fadprod/app/data/models/ChargementDetails.dart';
import 'package:fadprod/app/services/chargementServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DetailsController extends GetxController {
  final ChargementServices chargementServices = ChargementServices();
  TextEditingController textController = TextEditingController();
  var zoneText = ''.obs;
  var code = ''.obs;
  final count = 0.obs;
  var loading = true.obs;
  var chargement = Rx<ChargementDetails?>(null);
  var error = "".obs;
  var hintext = ''.obs;
  var hintTextColor = Colors.grey.obs; // To handle hint message color
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    code.value = Get.arguments as String;
    if (code.value.isNotEmpty) {
      getChargementDetails();
    }
  }

  Future<void> getChargementDetails() async {
    try {
      loading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      final response = await chargementServices.getChargementDetails(code.value, "", "");
      chargement.value = response.chargementDetails;
    } catch (e) {
      String errorMessage = e is Exception ? e.toString() : 'An unknown error occurred';
      error.value = errorMessage;
    } finally {
      loading.value = false;
    }
  }

  Future<void> addPacking(String packingCode) async {
    try {
      final response = await chargementServices.AddPack(code.value, packingCode);
      hintext.value = utf8.decode(response.packingConfirmation.runes.toList());
      if (response.colorConfirmation=="1"){hintTextColor.value = Colors.green;}else{
        hintTextColor.value = Colors.red;
        await _playErrorSound();
      }
    } catch (e) {
      String errorMessage = e is Exception ? e.toString() : "An unknown error occurred";
      hintext.value = errorMessage;
      await _playErrorSound();
      hintTextColor.value = Colors.red; // Set hint message color to red on error
    }
  }
   Future<void> _playErrorSound() async {
    await _audioPlayer.play(AssetSource('sounds/error.mp3'));
  }

  void updateZoneText(String newText) {
    zoneText.value = newText;
    validateAndSubmit(newText);  // Validate and submit whenever zoneText is updated
  }

  void validateAndSubmit(String packingCode) {
    print(packingCode);
    addPacking(packingCode);
  }

bool isValidPackingCode(String code) {
  RegExp pattern = RegExp(r'^B.*C\w{0,2}\d{3}$');
  return pattern.hasMatch(code);
}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}