import 'package:flutter/material.dart';

class ReviewButtonTransaction extends StatelessWidget {
  const ReviewButtonTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffCFFF8D),
          borderRadius: BorderRadius.circular(10)),
      child: const Text('Review',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.black)),
    );
  }
}
