import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final String text;
  LoginButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 238,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xff136068),
          borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
  }
}
