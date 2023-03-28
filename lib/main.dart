import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholar_chat_app/screens/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat_app/screens/chat_screen.dart';
import 'package:scholar_chat_app/screens/login_cubit/login_cubit.dart';
import 'package:scholar_chat_app/screens/login_screen.dart';
import 'package:scholar_chat_app/screens/register_screen.dart';
import 'package:scholar_chat_app/screens/register_screen/register_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit(),),
        BlocProvider(create: (_) => RegisterCubit(),),
        BlocProvider(create: (_) => ChatCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (_) => LoginScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          ChatScreen.routeName: (_) => ChatScreen(),
        },
      ),
    );
  }
}
