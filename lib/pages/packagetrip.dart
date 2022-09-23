import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/detailpage/detailpackagetrip.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';
import 'package:wisata_bali/widgets/card.dart';
import 'package:wisata_bali/widgets/category.dart';
import 'package:wisata_bali/widgets/packagetripcard.dart';

class PackageTrip extends StatefulWidget {
  const PackageTrip({Key? key}) : super(key: key);

  @override
  State<PackageTrip> createState() => _PackageTripState();
}

class _PackageTripState extends State<PackageTrip> {
  @override
  Widget build(BuildContext context) {
    List<double> ratingnilai = [1.0, 2.0, 3.0, 4.0];
    return Scaffold(
      extendBody: true,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Package Trip',
                        style: GoogleFonts.salsa(
                            fontSize: 36,
                            textStyle: TextStyle(color: Color(0xff136068))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 2,
            ))),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.64,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              itemCount: ratingnilai.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => DetailPackageTrip(
                              packageTripId: index,
                              image: 'assets/beach.jpg',
                            )));
                  },
                  child: PackageTripCard('Title $index', 'assets/beach.jpg',
                      'Price $index', ratingnilai[index]),
                );
              },
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15),
              height: 70,
              child: Column(
                children: [ButtonYellow(title: 'Filter')],
              )),
        ],
      )),
    );
  }
}
