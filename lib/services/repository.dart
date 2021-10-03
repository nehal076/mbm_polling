import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/services/api_provider.dart';

class Repository {
  Future<AllActivePolls> allActivePolls() => ApiProvider.fetchActivePolls();

  Future<CommonResponse> registerAndEnrollUser(Map<String, dynamic> request) =>
      ApiProvider.registerAndEnrollUser(request);

  Future<CommonResponse> loginUser(Map<String, dynamic> request) =>
      ApiProvider.loginUser(request);

  Future<CommonResponse> loginAdmin(Map<String, dynamic> request) =>
      ApiProvider.loginAdmin(request);

  Future<CommonResponse> createVote(Map<String, dynamic> request,
          {Map<String, dynamic>? postParams}) =>
      ApiProvider.createVote(request, postParams: postParams);
}
