import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/pages/accountpage.dart';
import 'package:wisata_bali/widgets/card.dart';


class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Wishlist',
                    style: GoogleFonts.salsa(
                        fontSize: 36,
                        textStyle: TextStyle(color: Color(0xff136068))
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context)=>Account())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 20, right: 20),
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Destination',),
                  Tab(text: 'Package Trip',)
                ],
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 540,
            padding: EdgeInsets.only(top: 20),
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 133,
                      child: Row(
                        children: [
                          Container(
                            width: 160,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage('assets/bg.jpg'),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(
                                      color: Color(0xff136068),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text('Bintang'),
                                  Text(
                                    'Bali Barat',
                                    style: TextStyle(
                                      color: Color(0xff136068),
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 133,
                      child: Row(
                        children: [
                          Container(
                            width: 160,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage('assets/bg.jpg'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(
                                        color: Color(0xff136068),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text('Bintang'),
                                  Text(
                                    'Pickup Point',
                                    style: TextStyle(
                                        color: Color(0xff136068),
                                        fontSize: 10
                                    ),
                                  ),
                                  Text(
                                    'Ngurah Rai Airport',
                                    style: TextStyle(
                                        color: Color(0xff136068),
                                        fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    '13.00 WITA',
                                    style: TextStyle(
                                        color: Color(0xff136068),
                                        fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    'IDR 1,500,000 /pax',
                                    style: TextStyle(
                                        color: Color(0xff136068),
                                        fontSize: 14,
                                      fontWeight: FontWeight.w100
                                    ),
                                  )

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
