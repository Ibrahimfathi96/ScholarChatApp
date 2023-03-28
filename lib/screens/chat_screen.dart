import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/models/message_model.dart';
import 'package:scholar_chat_app/screens/chat_cubit/chat_cubit.dart';

import '../components/text_message_widget.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = 'chat-screen';
  var controller = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;

    return Scaffold(
      appBar: AppBar(
        //in case we navigate with pushNamed there will ba back button
        //this attribute to cancel it
        //  automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 70,
              fit: BoxFit.cover,
            ),
            const Text(
              'Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22, color: Colors.white, fontFamily: 'Alkatra'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if(state is ChatSuccess){
                  messagesList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: controller,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? SenderChatBubble(message: messagesList[index])
                        : ReceivedChatBubble(
                      message: messagesList[index],
                    );
                  },
                  itemCount: messagesList.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: textEditingController,
              onSubmitted: (data) {
                if (data.isEmpty) {
                  return;
                }
                BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                textEditingController.clear();
                data = '';
                controller.animateTo(0,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    String message = textEditingController.text.trim();
                    if(message.isNotEmpty){
                    BlocProvider.of<ChatCubit>(context).sendMessage(message: textEditingController.text, email: email);
                    textEditingController.clear();
                    controller.animateTo(0,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn);
                    }
                  },
                ),
                hintText: 'send a message',
                hintStyle: const TextStyle(fontSize: 16, color: Colors.black87),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
