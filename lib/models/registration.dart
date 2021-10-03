// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'dart:convert';

CommonResponse registrationFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String registrationToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    required this.success,
    this.message,
  });

  bool success;
  String? message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
