class AddPackResponse {
  final String message;
  final String packingConfirmation;
  final String colorConfirmation;

  AddPackResponse({
    required this.message,
    required this.packingConfirmation,
    required this.colorConfirmation,
  });

  factory AddPackResponse.fromJson(Map<String, dynamic> json) {
    return AddPackResponse(
      message: json['message'] as String,
      packingConfirmation: json['data']['packingConfirmation'] as String,
      colorConfirmation: json['data']['colorConfirmation'] as String,
    );
  }
}
