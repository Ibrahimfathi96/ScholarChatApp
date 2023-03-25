import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/Components/custom_button.dart';
import 'package:scholar_chat_app/Components/custom_text_field.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/screens/RegisterScreen.dart';
import '../Utils/dialog utils.dart';
import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                        isLoading = true;
                        setState(() {});
                        try {
                          await userSignIn();
                          DialogUtils.showSnackBarMessage(context,
                              message: 'Sign in Successfully');
                          Navigator.pushReplacementNamed(context, ChatScreen.routeName,arguments: email);
                        } on FirebaseAuthException catch (exception) {
                          if (exception.code == 'user-not-found') {
                            DialogUtils.showSnackBarMessage(context,
                                message: 'there is no user with this email');
                          } else if (exception.code == 'wrong-password') {
                            DialogUtils.showSnackBarMessage(context,
                                message: 'user\'s password is wrong, try again' );
                          }
                        } catch (ex) {
                          DialogUtils.showSnackBarMessage(context,
                              message: 'there was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
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
                        Navigator.pushNamed(context, RegisterScreen.routeName);
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
    );
  }

  Future<void> userSignIn() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
