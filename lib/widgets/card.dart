import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {
  final String image;
  CardWidgets(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover
        )
      ),
    );
  }
}
