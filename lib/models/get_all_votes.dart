import 'dart:convert';

GetAllVotesByVoter getAllVotesByVoterFromJson(String str) =>
    GetAllVotesByVoter.fromJson(json.decode(str));

String getAllVotesByVoterToJson(GetAllVotesByVoter data) =>
    json.encode(data.toJson());

class GetAllVotesByVoter {
  GetAllVotesByVoter({
    required this.success,
    this.message,
  });

  bool success;
  List<Message>? message;

  factory GetAllVotesByVoter.fromJson(Map<String, dynamic> json) =>
      GetAllVotesByVoter(
        success: json["success"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message":
            message ?? List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.pollId,
    required this.voterHash,
    required this.ans,
  });

  String pollId;
  String voterHash;
  bool ans;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        pollId: json["pollID"],
        voterHash: json["voterHash"],
        ans: json["ans"],
      );

  Map<String, dynamic> toJson() => {
        "pollID": pollId,
        "voterHash": voterHash,
        "ans": ans,
      };
}
