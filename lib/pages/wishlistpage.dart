import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/pages/accountpage.dart';
import 'package:wisata_bali/widgets/wishlistdestinationcard.dart';
import 'package:wisata_bali/widgets/wishlistpackagetripcard.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<double> ratingnilai = [1.0, 2.0, 3.0, 4.0, 5.0];
    TabController tabController = TabController(length: 2, vsync: this);
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Wishlist',
                        style: GoogleFonts.salsa(
                            fontSize: 36,
                            textStyle: TextStyle(
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068))),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const Account()));
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                        child: const CircleAvatar(
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
                    controller: tabController,
                    labelColor: isDarkTheme ? Colors.white : Colors.black,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: isDarkTheme ? Colors.white : Colors.black,
                    tabs: const [
                      Tab(
                        text: 'Destination',
                      ),
                      Tab(
                        text: 'Package Trip',
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.only(top: 20),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                      itemCount: ratingnilai.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    DetailDestination(destinationId: index)));
                          },
                          child: WishlistDestinationCard(
                              image: 'assets/bg.jpg',
                              title: 'Title $index',
                              rating: ratingnilai[index],
                              place: 'place $index'),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: ratingnilai.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: WishlistPackageTripCard(
                            title: 'Title $index',
                            image: 'assets/bg.jpg',
                            rating: ratingnilai[index],
                            price: '1.500.000',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
