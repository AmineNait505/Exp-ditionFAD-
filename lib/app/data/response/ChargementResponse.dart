import 'package:fadprod/app/data/models/ChargementDetails.dart';

class ChargementDetailsResponse {
  final String message;
  final ChargementDetails chargementDetails;

  ChargementDetailsResponse({
    required this.message,
    required this.chargementDetails,
  });

  factory ChargementDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ChargementDetailsResponse(
      message: json['message'] as String,
      chargementDetails: ChargementDetails.fromJson(json['data'][0] as Map<String, dynamic>),
    );
  }
}
