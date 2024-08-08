import 'dart:convert';
import 'package:fadprod/app/data/response/AddPackResponse.dart';
import 'package:fadprod/app/data/response/ChargementDetailsResponse.dart';
import 'package:fadprod/app/data/response/ChargementResponse.dart';
import 'package:fadprod/utils/constants.dart';
import 'package:http/http.dart' as http;

class ChargementServices {
 Future<ChargementResponse> getChargementOpen(String totalRecords) async {
    var url = Uri.parse('$BASE_URL/exportLoading');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'totalRecords': totalRecords, // key-value pair for form data
        },
      );

      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody['message']);
        return ChargementResponse.fromJson(responseBody);
      } else {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        final String errorMessage = errorBody['message'] ?? 'Aucun chargement disponible pour le moment.\nVeuillez réessayer plus tard.';
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("Exception $e");
      if (e is http.ClientException) {
        throw Exception('Problème de connexion');
      } else {
        throw Exception('An unexpected error occurred');
      }
    }
  }

   Future<ChargementDetailsResponse> getChargementDetails(String loadingFilter,String circuitName, String vehicle) async {
    var url = Uri.parse('$BASE_URL/exportLoadingDetail');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'loadingFilter': loadingFilter,
          'circuitName':circuitName,
          'vehicle':vehicle
        },
      );

      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody['message']);
        return ChargementDetailsResponse.fromJson(responseBody);
      } else {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        final String errorMessage = errorBody['message'] ?? 'Failed to load chargements';
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("Exception $e");
      throw Exception('Failed to load chargements');
    }
  }
  Future<AddPackResponse>AddPack(String loadingFilter,String packingCode)async {
      var url = Uri.parse(
      '$BASE_URL/addPacking'
      '?loadingFilter=$loadingFilter'
      '&packingCode=$packingCode'
      '&packingConfirmation=fff'
      '&colorConfirmation=1',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded', 
        },
      );

      print("Response body: ${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody['message']);
        return AddPackResponse.fromJson(responseBody);
      } else {
        final Map<String, dynamic> errorBody = jsonDecode(response.body);
        final String errorMessage = errorBody['message'] ?? 'Failed to add pack';
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      print("Exception $e");
      throw Exception('Failed to add pack');
    }
  }
}

