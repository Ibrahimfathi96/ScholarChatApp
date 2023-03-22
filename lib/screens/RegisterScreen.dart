import 'package:flutter/material.dart';
import 'package:scholar_chat_app/screens/LoginScreen.dart';

import '../Components/custom_button.dart';
import '../Components/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                  fontSize: 32, color: Colors.white, fontFamily: 'Pacifico'),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              'Register',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14,
            ),
            TextFieldWidget(
              hintText: 'Email',
            ),
            SizedBox(
              height: 14,
            ),
            TextFieldWidget(
              hintText: 'Password',
            ),
            SizedBox(
              height: 14,
            ),
            TextFieldWidget(
              hintText: 'Confirm Password',
            ),
            SizedBox(
              height: 14,
            ),
            ButtonWidget(buttonTxt: 'Register'),
            SizedBox(
              height: 14,
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
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
