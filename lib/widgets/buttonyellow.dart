import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonYellow extends StatelessWidget {
  final String title;
  const ButtonYellow({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 129,
      height: 42,
      decoration: BoxDecoration(
          color: Color(0xffFCE40C),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        title,
        style: GoogleFonts.salsa(
            fontSize: 12,
          color: Colors.black
        ),
      ),
    );
  }
}
