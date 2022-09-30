import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchCard extends StatelessWidget {
  final String title;
  final double rating;
  final String category;
  final String location;
  final String image;

  const SearchCard(
      {Key? key,
      required this.category,
      required this.title,
      required this.rating,
      required this.location,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(15),
      height: 133,
      width: 370,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('http://10.0.2.2:3000/$image'),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkTheme ? Colors.white : const Color(0xff136068),
                    ),
                  ),
                  Container(
                      child: RatingBarIndicator(
                    rating: rating,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color:
                          isDarkTheme ? Colors.white : const Color(0xff136068),
                    ),
                  )),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 14),
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
