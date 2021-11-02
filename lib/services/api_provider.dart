import 'dart:convert';
import 'dart:developer';
import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/get_all_votes.dart';
import 'package:mbm_voting/models/get_result_by_poll_id.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/services/api_service.dart';

class ApiProvider {
  static Future<AllActivePolls> fetchActivePolls() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.GET, 'query/allActivePolls', null, headers);

    log(response!.body);

    return AllActivePolls.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> registerAndEnrollUser(
      Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'registerAndEnrollUser', request, headers);
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> loginUser(Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'loginUser', request, headers);
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> loginAdmin(Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'loginAdmin', request, headers);
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> createVote(Map<String, dynamic> request,
      {Map<String, dynamic>? postParams}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'invoke/createVote', request, headers,
        postParams: postParams);
    log(jsonEncode([request, postParams]));
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }

  static Future<GetAllVotesByVoter> getAllVotesByVoter(
      Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.GET, 'query/getAllVotesByVoter', request, headers);

    log(jsonEncode(request));
    log(response!.body);

    return GetAllVotesByVoter.fromJson(json.decode(response.body));
  }

  static Future<AllActivePolls> allClosedPolls() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.GET, 'query/allClosedPolls', null, headers);

    log(response!.body);

    return AllActivePolls.fromJson(json.decode(response.body));
  }

  static Future<GetResultByPollId> getResultByPollId(
      Map<String, dynamic> request) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.GET, 'query/getResultByPollId', request, headers);

    log(jsonEncode(request));
    log(response!.body);

    return GetResultByPollId.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> closePoll(Map<String, dynamic> request,
      {Map<String, dynamic>? postParams}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'invoke/closePoll', request, headers,
        postParams: postParams);
    log(jsonEncode(request));
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> createPoll(Map<String, dynamic> request,
      {Map<String, dynamic>? postParams}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await ApiService.makeRequest(
        RequestType.POST, 'invoke/createPoll', request, headers,
        postParams: postParams);
    log(jsonEncode(request));
    log(response!.body);

    return CommonResponse.fromJson(json.decode(response.body));
  }
}
