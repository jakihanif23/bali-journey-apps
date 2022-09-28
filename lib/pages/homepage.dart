import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/detailpage/detailpackagetrip.dart';
import 'package:wisata_bali/models/categorymodels.dart';
import 'package:wisata_bali/models/listmodels.dart';
import 'package:wisata_bali/pages/accountpage.dart';
import 'package:wisata_bali/pages/categorypage.dart';
import 'package:wisata_bali/widgets/card.dart';
import 'package:wisata_bali/widgets/category.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryModel? categoryModel = null;

  @override
  Widget build(BuildContext context) {
    List<String> images = ['assets/bg.jpg', 'assets/beach.jpg', 'assets/bg.jpg', 'assets/beach.jpg'];
    List<CategoryModel> category = [
      CategoryModel(id: 1, name: 'Beach'),
      CategoryModel(id: 2, name: 'Hotel'),
      CategoryModel(id: 2, name: 'Gunung')
    ];
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find Your',
                              style: GoogleFonts.salsa(
                                  fontSize: 36,
                                  textStyle: TextStyle(color: isDarkTheme? Color(0xffD9F9F8) : Color(0xff136068))
                              ),
                            ),
                            Text(
                              'Destination',
                              style: GoogleFonts.salsa(
                                  fontSize: 36,
                                  textStyle: TextStyle(color: isDarkTheme? Color(0xffD9F9F8) : Color(0xff136068))
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                              CupertinoPageRoute(builder: (context)=>Account())
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/man.jpg'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                    height: 80,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context)=>CategoryPage(cateId: category[index].name)));
                              },
                              child: CategoryWidgets(
                                  category[index].name
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child: Text(
                    'Recommendation Destination',
                    style: GoogleFonts.salsa(
                        fontSize: 24,
                        textStyle: TextStyle(color: isDarkTheme? Color(0xffD9F9F8) : Color(0xff136068))
                    ),
                  ),
                ),

                //Go To Destination Page
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    height: 300,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (context)=>DetailDestination(destinationId: index, image: images[index],))
                                );
                              },
                              child: CardWidgets(
                                  images[index]
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                  child: Text(
                    'Recommendation Package Trip',
                    style: GoogleFonts.salsa(
                        fontSize: 24,
                        textStyle: TextStyle(color: isDarkTheme? Color(0xffD9F9F8) : Color(0xff136068))
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    height: 300,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index){
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (context)=>DetailPackageTrip(packageTripId: index, image: images[index]))
                                );
                              },
                              child: CardWidgets(
                                  images[index]
                              ),
                            ),
                          );
                        },
                      ),
                    )
                ),
                SizedBox(height: 20,),
              ],
            )
        ),
      ),
    );
  }
}

