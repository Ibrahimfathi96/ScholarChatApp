import 'package:scholar_chat_app/Constants/Constants.dart';

class Message{
  String message;

  Message({required this.message});

  factory Message.fromJson(json) {
    return Message(
      message: json[kMessage],
    );
  }
//
}