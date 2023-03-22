import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
String buttonTxt;

ButtonWidget({required this.buttonTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          buttonTxt,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
