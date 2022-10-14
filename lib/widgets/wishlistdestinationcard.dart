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
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 150,
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
                    style: TextStyle(
                        color: isDarkTheme
                            ? Colors.white
                            : const Color(0xff136068),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: RatingBarIndicator(
                      itemSize: 30,
                      itemCount: 5,
                      rating: rating,
                      itemBuilder: (contex, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Text(
                    place,
                    style: TextStyle(
                        color: isDarkTheme
                            ? Colors.white
                            : const Color(0xff136068),
                        fontSize: 14),
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
