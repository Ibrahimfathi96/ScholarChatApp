import 'package:flutter/material.dart';
import 'package:scholar_chat_app/screens/LoginScreen.dart';
import 'package:scholar_chat_app/screens/RegisterScreen.dart';

void main() {
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
      },
    );
  }
}
