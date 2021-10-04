import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mbm_voting/common/constants.dart';
import 'package:mbm_voting/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum RequestType { GET, POST, DELETE }

class ApiService {
  static const String _baseUrl = Constants.baseUrl;

  static Future<Response?> makeRequest(RequestType requestType, String path,
      parameter, Map<String, String> headers,
      {Map<String, dynamic>? postParams}) async {
    var client = http.Client();

    switch (requestType) {
      case RequestType.GET:
        try {
          String queryString = Uri(queryParameters: parameter).query;
          final Response response = await client.get(
            Uri.parse('$_baseUrl/$path?' + queryString),
            headers: headers,
          );
          if (response.statusCode == 200) {
            return response;
          } else {
            return null;
          }
        } on SocketException {
          Alert(
            context: navigatorKey.currentContext!,
            type: AlertType.error,
            desc: "Socket Exception",
            buttons: [
              DialogButton(
                child: const Text(
                  "Okay",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(navigatorKey.currentContext!),
                width: 120,
              )
            ],
          ).show();
        }
        break;

      case RequestType.POST:
        try {
          String queryString = Uri(queryParameters: postParams).query;
          final Response response = await client.post(
            Uri.parse("$_baseUrl/$path?" + queryString),
            headers: headers,
            body: json.encode(parameter),
          );
          if (response.statusCode == 200) {
            return response;
          } else {
            return null;
          }
        } on SocketException {
          Alert(
            context: navigatorKey.currentContext!,
            type: AlertType.error,
            desc: "Socket Exception",
            buttons: [
              DialogButton(
                child: const Text(
                  "Okay",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(navigatorKey.currentContext!),
                width: 120,
              )
            ],
          ).show();
        }
        break;
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }
}
