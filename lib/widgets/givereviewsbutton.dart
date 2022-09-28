import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiveReviewButton extends StatelessWidget {
  const GiveReviewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 129,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffD9F9F8),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        'Give Review',
        style: GoogleFonts.salsa(
            fontSize: 16,
          color: Colors.black
        ),
      ),
    );
  }
}
