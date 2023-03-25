import 'package:flutter/material.dart';
import 'package:scholar_chat_app/models/message_model.dart';

import '../Constants/Constants.dart';

class ReceivedChatBubble extends StatelessWidget {
Message message;

ReceivedChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 25,bottom: 25,right: 16),
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25) ,
              topRight: Radius.circular(25)
          ),
          color: kPrimaryColor,

        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}
class SenderChatBubble extends StatelessWidget {
Message message;

SenderChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 25,bottom: 25,right: 16),
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25) ,
              topRight: Radius.circular(25)
          ),
          color: kSecondaryColor,

        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}
