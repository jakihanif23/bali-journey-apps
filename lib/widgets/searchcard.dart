import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchCard extends StatelessWidget {
  final String title;
  final double rating;
  final String type;
  final String location;
  final String image;

  const SearchCard(
      {Key? key,
      required this.type,
      required this.title,
      required this.rating,
      required this.location,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.all(15),
      height: 133,
      width: 370,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme?Colors.white:Color(0xff136068),
                    ),
                  ),
                  Container(
                      child: RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: isDarkTheme?Colors.white:Color(0xff136068),
                    ),
                  )),
                  Text(
                    type,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14),
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
