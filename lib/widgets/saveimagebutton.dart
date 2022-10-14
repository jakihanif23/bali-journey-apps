import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveImageButton extends StatelessWidget {
  const SaveImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 129,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffD9F9F8),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        'Save Image',
        style: GoogleFonts.lato(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
