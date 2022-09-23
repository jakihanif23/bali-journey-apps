import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 133,
      child: Row(
        children: [
          Container(
            width: 160,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Color(0xff136068),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: RatingBarIndicator(
                      itemSize: 20,
                      itemCount: 5,
                      rating: rating,
                      itemBuilder: (contex, index) => Icon(
                        Icons.star,
                        color: Color(0xff136068),
                      ),
                    ),
                  ),
                  Text(
                    'Pickup Point',
                    style: TextStyle(color: Color(0xff136068), fontSize: 10),
                  ),
                  Text(
                    'Ngurah Rai Airport',
                    style: TextStyle(
                        color: Color(0xff136068),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '13.00 WITA',
                    style: TextStyle(
                        color: Color(0xff136068),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'IDR $price /pax',
                    style: TextStyle(
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
