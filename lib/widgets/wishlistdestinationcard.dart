import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WishlistDestinationCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;
  final String place;

  const WishlistDestinationCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.rating,
      required this.place})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
                        color: isDarkTheme?Colors.white:Color(0xff136068),
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
                        color: isDarkTheme?Colors.white:Color(0xff136068),
                      ),
                    ),
                  ),
                  Text(
                    place,
                    style: TextStyle(color: isDarkTheme?Colors.white: Color(0xff136068), fontSize: 14),
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
