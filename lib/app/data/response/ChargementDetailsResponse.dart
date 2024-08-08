import 'package:fadprod/app/data/models/Chargement.dart';

class ChargementResponse {
  final String message;
  final List<Chargement> chargements;

  ChargementResponse({
    required this.message,
    required this.chargements,
  });

  factory ChargementResponse.fromJson(Map<String, dynamic> json) {
    return ChargementResponse(
      message: json['message'] as String,
      chargements: (json['data'] as List<dynamic>)
          .map((item) => Chargement.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
