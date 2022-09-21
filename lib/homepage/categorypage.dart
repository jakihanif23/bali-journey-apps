import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/homepage/account.dart';
import 'package:wisata_bali/widgets/card.dart';

class CategoryPage extends StatefulWidget {
  final int cateId;
  const CategoryPage({Key? key, required this.cateId}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category ${widget.cateId}',
                        style: GoogleFonts.salsa(
                            fontSize: 36,
                            textStyle: TextStyle(color: Color(0xff136068))
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>Account()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          'All Category ${widget.cateId}',
                          style: GoogleFonts.salsa(
                              fontSize: 24,
                              textStyle: TextStyle(color: Color(0xff136068))
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          'Recommended Category ${widget.cateId}',
                          style: GoogleFonts.salsa(
                              fontSize: 24,
                              textStyle: TextStyle(color: Color(0xff136068))
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
