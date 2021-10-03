import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/get_all_votes.dart';
import 'package:mbm_voting/models/get_result_by_poll_id.dart';
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

  Future<GetAllVotesByVoter> getAllVotesByVoter(Map<String, dynamic> request) =>
      ApiProvider.getAllVotesByVoter(request);

  Future<AllActivePolls> allClosedPolls() => ApiProvider.allClosedPolls();

  Future<GetResultByPollId> getResultByPollId(Map<String, dynamic> request) =>
      ApiProvider.getResultByPollId(request);

  Future<CommonResponse> closePoll(Map<String, dynamic> request,
          {Map<String, dynamic>? postParams}) =>
      ApiProvider.closePoll(request, postParams: postParams);

  Future<CommonResponse> createPoll(Map<String, dynamic> request,
          {Map<String, dynamic>? postParams}) =>
      ApiProvider.createPoll(request, postParams: postParams);
}
