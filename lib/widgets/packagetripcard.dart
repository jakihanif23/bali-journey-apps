import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PackageTripCard extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final double rating;
  PackageTripCard(this.title, this.image, this.price, this.rating);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Column(
      children: [
        Divider(),
        Container(
          height: 133,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                              color: isDarkTheme?Colors.white:Color(0xff136068)
                          ),
                        ),
                      ),
                      Container(
                        child: RatingBarIndicator(
                          rating: rating,
                          itemCount: 5,
                          itemSize: 23,
                          itemBuilder: (context, index)=>Icon(Icons.star, color: isDarkTheme?Colors.white:Color(0xff136068),),
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'IDR $price /pax',
                          style: TextStyle(
                              color: isDarkTheme?Colors.white:Color(0xff136068),
                              fontSize: 14,
                              fontWeight: FontWeight.w100
                          ),
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
