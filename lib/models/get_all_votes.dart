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
  dynamic message;

  factory GetAllVotesByVoter.fromJson(Map<String, dynamic> json) =>
      GetAllVotesByVoter(
        success: json["success"],
        message: json["message"] is List
            ? List<Message>.from(
                json["message"].map((x) => Message.fromJson(x)))
            : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message is List
            ? List<dynamic>.from(message!.map((x) => x.toJson()))
            : message,
      };
}

class Message {
  Message({
    required this.pollId,
    required this.ques,
    required this.voterHash,
    required this.ans,
    required this.txnId,
  });

  String pollId;
  String ques;
  String voterHash;
  bool ans;
  String txnId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        pollId: json["pollID"],
        ques: json["ques"],
        voterHash: json["voterHash"],
        ans: json["ans"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "pollID": pollId,
        "ques": ques,
        "voterHash": voterHash,
        "ans": ans,
        "txnId": txnId,
      };
}
