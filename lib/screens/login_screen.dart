import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/Components/custom_button.dart';
import 'package:scholar_chat_app/Components/custom_text_field.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/screens/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat_app/screens/register_screen.dart';
import '../Utils/dialog utils.dart';
import 'chat_screen.dart';
import 'login_cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login-screen';
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushReplacementNamed(context, ChatScreen.routeName,
              arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          DialogUtils.showSnackBarMessage(context, message: state.errorMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  Text(
                    'Scholar Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico'),
                  ),
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Alkatra',
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  TextFormFieldWidget(
                    isObscured: false,
                    iconData: Icons.email,
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  TextFormFieldWidget(
                    isObscured: true,
                    iconData: Icons.lock,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ButtonWidget(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .userSignIn(email: email!, password: password!);
                        }
                      },
                      buttonTxt: 'Sign In'),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account?',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          '   Register',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xffC7EDE6)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
