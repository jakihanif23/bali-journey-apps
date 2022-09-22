import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                                  textStyle: TextStyle(color: Color(0xff136068))
                              ),
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
                      )
                    )
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.64,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10.0),
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return PackageTripCard('Title $index', 'assets/beach.jpg', 'Price $index');
                    },
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 15),
                    height: 70,
                    child: Column(
                      children: [
                        ButtonYellow(title: 'Filter')
                      ],
                    )
                ),

              ],
            )
        ),
      ),
    );
  }
}
