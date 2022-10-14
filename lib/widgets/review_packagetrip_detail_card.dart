import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ReviewPackageTripDetailCard extends StatelessWidget {
  final String title;
  final double rating;
  final int price;
  final String image;
  const ReviewPackageTripDetailCard(
      {super.key,
      required this.title,
      required this.rating,
      required this.price,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final currencyformatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
    return CachedNetworkImage(
        imageUrl: 'https://api-bali-journey.herokuapp.com/$image',
        imageBuilder: (context, imageProvider) => Container(
              margin: const EdgeInsets.all(15),
              height: 150,
              width: 370,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
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
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff136068),
                            ),
                          ),
                          Container(
                              child: RatingBarIndicator(
                            rating: rating,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          )),
                          Text(
                            currencyformatter.format(price),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
