import 'dart:ui';

import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {
  final String image;
  final String address;
  const CardWidgets(this.image, this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage('http://10.0.2.2:3000/$image'),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Positioned(
              bottom: 15,
              left: 13,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 5, right: 8),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.fmd_good,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          address,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
