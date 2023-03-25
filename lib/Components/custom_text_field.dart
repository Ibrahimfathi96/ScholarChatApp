import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
String hintText;
Function(String) onChanged;
IconData iconData;

TextFormFieldWidget({required this.hintText, required this.onChanged, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return "this field is required";
        }
      },
      style: TextStyle(color: Colors.white,fontSize: 18),
      onChanged:onChanged ,
      decoration: InputDecoration(
        prefixIcon: Icon(iconData,color: Colors.white70,),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,fontSize: 18
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
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
