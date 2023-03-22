import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
String hintText;

TextFieldWidget({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,fontSize: 18

        ),
        enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
      ),
    );
  }
}
