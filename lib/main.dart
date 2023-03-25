import 'package:flutter/material.dart';
import 'package:scholar_chat_app/screens/ChatScreen.dart';
import 'package:scholar_chat_app/screens/LoginScreen.dart';
import 'package:scholar_chat_app/screens/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChatApp());
}

class ScholarChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        ChatScreen.routeName:(_)=>ChatScreen(),
      },
    );
  }
}
