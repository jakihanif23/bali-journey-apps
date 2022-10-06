import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class PackageTripCard extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final double rating;
  const PackageTripCard(this.title, this.image, this.price, this.rating);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final currencyformatter =
        NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
    return Column(
      children: [
        const Divider(),
        Container(
          height: 133,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://api-bali-journey.herokuapp.com/$image'),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff136068)),
                        ),
                      ),
                      Container(
                          child: RatingBarIndicator(
                        rating: rating,
                        itemCount: 5,
                        itemSize: 23,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: isDarkTheme
                              ? Colors.white
                              : const Color(0xff136068),
                        ),
                      )),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${currencyformatter.format(int.parse(price))}/pax',
                          style: TextStyle(
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff136068),
                              fontSize: 14,
                              fontWeight: FontWeight.w100),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
