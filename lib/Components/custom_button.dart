import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
String buttonTxt;
VoidCallback onTap;

ButtonWidget({required this.buttonTxt,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            buttonTxt,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
