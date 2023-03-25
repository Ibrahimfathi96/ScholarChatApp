import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_app/Components/textMessageWidget.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/models/message_model.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = 'chat-screen';
  var controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for(int i=0; i < snapshot.data!.docs.length; i++){
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
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
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Alkatra'),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return  messagesList[index].id == email? 
                        SenderChatBubble(message: messagesList[index])
                        : ReceivedChatBubble(message: messagesList[index],);
                    },
                    itemCount: messagesList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (data) {
                      messages.add({
                        kMessageCollections: data,
                        kCreatedAt:DateTime.now(),
                        kId:email
                      });
                      textEditingController.clear();
                      controller.animateTo(
                          0,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      hintText: 'send a message',
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.black87),
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
        } else {
          return Text('Loading....');
        }
      },
    );
  }
}
