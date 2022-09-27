import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidgets extends StatelessWidget {

  final String? text;
  CategoryWidgets(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Text(
        text!,
        style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
