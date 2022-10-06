import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidgets extends StatelessWidget {
  final String? text;
  const CategoryWidgets(this.text);
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: 140,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color:
              isDarkTheme ? const Color(0xffD9F9F8) : const Color(0xffD9D9D9),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(
        text!,
        style: GoogleFonts.lato(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
