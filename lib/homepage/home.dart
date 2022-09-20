import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/homepage/account.dart';
import 'package:wisata_bali/widgets/card.dart';
import 'package:wisata_bali/widgets/category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                                textStyle: TextStyle(color: Color(0xff136068))
                            ),
                          ),
                          Text(
                            'Destination',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle: TextStyle(color: Color(0xff136068))
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>Account()));
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: CategoryWidgets('$index'),
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
                      textStyle: TextStyle(color: Color(0xff136068))
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  height: 300,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/beach.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/bg.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/beach.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/bg.jpg'),
                        ),
                      ],
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Text(
                  'Recommendation Package Trip',
                  style: GoogleFonts.salsa(
                      fontSize: 24,
                      textStyle: TextStyle(color: Color(0xff136068))
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  height: 300,
                  child: Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/beach.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/bg.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/bg.jpg'),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: CardWidgets('assets/beach.jpg'),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 20,)
            ],
          )
        ),
      ),
    );
  }
}
