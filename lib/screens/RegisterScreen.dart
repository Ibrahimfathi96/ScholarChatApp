import 'package:flutter/material.dart';
import 'package:scholar_chat_app/Constants/Colors.dart';
import '../Components/custom_button.dart';
import '../Components/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          children: [
            SizedBox(height: size.height / 15,),
            Image.asset('assets/images/scholar.png',height: 100,),
            Text(
              'Scholar Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32, color: Colors.white, fontFamily: 'Pacifico'),
            ),
            SizedBox(height: size.height / 15,),
            Text(
              'Register',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height / 50,),
            TextFieldWidget(
              hintText: 'Email',
            ),
            SizedBox(
              height: size.height / 50,
            ),
            TextFieldWidget(
              hintText: 'Password',
            ),
            SizedBox(
              height: size.height / 50,
            ),
            TextFieldWidget(
              hintText: 'Confirm Password',
            ),
            SizedBox(
              height: size.height / 50,
            ),
            ButtonWidget(buttonTxt: 'Register'),
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
                    style: TextStyle(fontSize: 18, color: Color(0xffC7EDE6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
