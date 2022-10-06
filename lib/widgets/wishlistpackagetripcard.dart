import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class WishlistPackageTripCard extends StatelessWidget {
  final String title;
  final double rating;
  final String image;
  final String price;

  const WishlistPackageTripCard(
      {Key? key,
      required this.title,
      required this.rating,
      required this.image,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyformatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 133,
      child: Row(
        children: [
          Container(
            width: 160,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://api-bali-journey.herokuapp.com/$image'),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Color(0xff136068),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: RatingBarIndicator(
                      itemSize: 20,
                      itemCount: 5,
                      rating: rating,
                      itemBuilder: (contex, index) => const Icon(
                        Icons.star,
                        color: Color(0xff136068),
                      ),
                    ),
                  ),
                  const Text(
                    'Pickup Point',
                    style: TextStyle(color: Color(0xff136068), fontSize: 10),
                  ),
                  const Text(
                    'Ngurah Rai Airport',
                    style: TextStyle(
                        color: Color(0xff136068),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    '13.00 WITA',
                    style: TextStyle(
                        color: Color(0xff136068),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${currencyformatter.format(int.parse(price))}/pax',
                    style: const TextStyle(
                        color: Color(0xff136068),
                        fontSize: 14,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
