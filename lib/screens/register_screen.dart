import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/screens/register_screen/register_cubit.dart';
import '../Components/custom_button.dart';
import '../Components/custom_text_field.dart';
import '../Utils/dialog utils.dart';
import 'chat_cubit/chat_cubit.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register-screen';
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener:(context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          isLoading = false;
          Navigator.pushReplacementNamed(context, ChatScreen.routeName,
              arguments: email);
        } else if (state is RegisterFailure) {
          isLoading = false;
          DialogUtils.showSnackBarMessage(context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                      'Register',
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
                      buttonTxt: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).userRegistration(email: email!, password: password!);
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '   Sign In',
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
        );
      },
    );
  }
}
