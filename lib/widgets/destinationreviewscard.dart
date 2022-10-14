import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DestinationReviewCard extends StatelessWidget {
  final String comment;
  final String name;
  final double rating;
  final String image;
  const DestinationReviewCard(
      {Key? key,
      required this.comment,
      required this.name,
      required this.image,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 377,
      decoration: BoxDecoration(
          color: const Color(0xffD9F9F8),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://api-bali-journey.herokuapp.com/$image'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: RatingBarIndicator(
                                rating: rating,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Color(0xff136068),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                comment,
                style: const TextStyle(fontSize: 15, color: Colors.black),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
