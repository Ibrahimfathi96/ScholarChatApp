import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/Constants/Constants.dart';
import 'package:scholar_chat_app/Utils/dialog%20utils.dart';
import 'package:scholar_chat_app/screens/ChatScreen.dart';
import '../Components/custom_button.dart';
import '../Components/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register-screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   String? email;

   String? password;

   String? confirmPassword;

  bool isLoading = false;

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
                      isLoading = true;
                      setState(() {});
                      try {
                        await userRegistration();
                        DialogUtils.showSnackBarMessage(context,
                            message:
                                'your account has been successfully created');
                        Navigator.pushReplacementNamed(context, ChatScreen.routeName,arguments: email);
                      } on FirebaseAuthException catch (exception) {
                        if (exception.code == 'weak password') {
                          DialogUtils.showSnackBarMessage(context,
                              message: 'weak password, please try again');
                        } else if (exception.code == 'email-already-in-use') {
                          DialogUtils.showSnackBarMessage(context,
                              message: 'email already exists');
                        }
                      } catch (ex) {
                        DialogUtils.showSnackBarMessage(context,
                            message: 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
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
  }

  Future<void> userRegistration() async {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
