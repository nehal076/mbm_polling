// To parse this JSON data, do
//
//     final allActivePolls = allActivePollsFromJson(jsonString);

import 'dart:convert';

AllActivePolls allActivePollsFromJson(String str) =>
    AllActivePolls.fromJson(json.decode(str));

String allActivePollsToJson(AllActivePolls data) => json.encode(data.toJson());

class AllActivePolls {
  AllActivePolls({
    required this.success,
    this.message,
  });

  bool success;
  List<Message>? message;

  factory AllActivePolls.fromJson(Map<String, dynamic> json) => AllActivePolls(
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
    required this.ques,
    required this.active,
  });

  String pollId;
  String ques;
  bool active;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        pollId: json["pollID"],
        ques: json["ques"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "pollID": pollId,
        "ques": ques,
        "active": active,
      };
}
