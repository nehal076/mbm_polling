import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mbm_voting/common/constants.dart';

enum RequestType { GET, POST, DELETE }

class ApiService {
  static const String _baseUrl = Constants.baseUrl;

  static Future<Response?> makeRequest(RequestType requestType, String path,
      parameter, Map<String, String> headers,
      {Map<String, dynamic>? postParams}) async {
    var client = http.Client();

    switch (requestType) {
      case RequestType.GET:
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
      case RequestType.POST:
        String queryString = Uri(queryParameters: postParams).query;
        return client.post(
          Uri.parse("$_baseUrl/$path?" + queryString),
          headers: headers,
          body: json.encode(parameter),
        );
      default:
        return throw Exception("The HTTP request method is not found");
    }
  }
}
