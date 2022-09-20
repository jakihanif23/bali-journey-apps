import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Image.asset(
        'assets/bg.jpg',
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
      ),
    );
  }
}
