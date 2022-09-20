import 'package:flutter/material.dart';

class PackageTripCard extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  PackageTripCard(this.title, this.image, this.price);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Container(
          height: 133,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all()
          ),
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xff136068)
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'IDR $price /pax',
                            style: TextStyle(
                                color: Color(0xff136068),
                                fontSize: 14,
                                fontWeight: FontWeight.w100
                            ),
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
