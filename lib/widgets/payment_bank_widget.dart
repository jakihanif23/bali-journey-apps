import 'package:flutter/material.dart';

class PaymentBankWidget extends StatelessWidget {
  final String image;
  final String title;
  const PaymentBankWidget(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fitWidth)),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$title Virtual Account',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
