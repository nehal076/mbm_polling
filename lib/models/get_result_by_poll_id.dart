import 'dart:convert';

GetResultByPollId getResultByPollIdFromJson(String str) =>
    GetResultByPollId.fromJson(json.decode(str));

String getResultByPollIdToJson(GetResultByPollId data) =>
    json.encode(data.toJson());

class GetResultByPollId {
  GetResultByPollId({
    required this.success,
    required this.message,
  });

  bool success;
  GetResultMessage message;

  factory GetResultByPollId.fromJson(Map<String, dynamic> json) =>
      GetResultByPollId(
        success: json["success"],
        message: GetResultMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class GetResultMessage {
  GetResultMessage({
    required this.resultId,
    required this.pollId,
    required this.yes,
    required this.no,
  });

  String resultId;
  String pollId;
  int yes;
  int no;

  factory GetResultMessage.fromJson(Map<String, dynamic> json) =>
      GetResultMessage(
        resultId: json["resultID"],
        pollId: json["pollID"],
        yes: json["yes"],
        no: json["no"],
      );

  Map<String, dynamic> toJson() => {
        "resultID": resultId,
        "pollID": pollId,
        "yes": yes,
        "no": no,
      };
}
