import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../Constants/Constants.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);
  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessageCollections: message,
        kCreatedAt: DateTime.now(),
        kId: email
      });
    } on Exception catch (e) {
      // TODO: Handle UI Failure State
      emit(ChatFailed());
    }
  }
}
