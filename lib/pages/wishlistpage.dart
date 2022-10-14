import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/wishlistapi.dart';
import 'package:wisata_bali/detailpage/detail_packagetrip_user.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/detailpage/detaildestination_user.dart';
import 'package:wisata_bali/detailpage/detailpackagetrip.dart';
import 'package:wisata_bali/models/wishlist_destination_model.dart';
import 'package:wisata_bali/models/wishlist_packagetrip_model.dart';
import 'package:wisata_bali/widgets/packagetripcard.dart';
import 'package:wisata_bali/widgets/wishlistdestinationcard.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with TickerProviderStateMixin {
  var loginChecker = false;
  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('jwt') == null) {
      print('user null');
    } else {
      setState(() {
        loginChecker = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    getWishDest();
    getWishPack();
  }

  List<WishlistDestination>? listDestination;
  var isLoadedDest = false;
  getWishDest() async {
    var prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    if (getString != null) {
      listDestination = await WishlistApi()
          .getListDestinations(prefs.getString('jwt').toString());
      if (listDestination!.isNotEmpty) {
        setState(() {
          isLoadedDest = true;
        });
      }
    }
  }

  var isLoadedPack = false;
  List<WishlistPackageTrip>? listPackageTrip;
  getWishPack() async {
    var prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    if (getString != null) {
      listPackageTrip = await WishlistApi()
          .getListPackageTrip(prefs.getString('jwt').toString());
      if (listPackageTrip!.isNotEmpty) {
        setState(() {
          isLoadedPack = true;
        });
      }
    }
  }

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
                    loginChecker
                        ? Visibility(
                            visible: isLoadedDest,
                            replacement:
                                const Center(child: Text('Wishlist Empty')),
                            child: ListView.builder(
                              itemCount: listDestination?.length,
                              itemBuilder: (context, index) {
                                var id = listDestination![index].id;
                                var rating = double.parse(
                                    listDestination![index].rating.toString());
                                var address = listDestination![index].address;
                                var img = listDestination![index].images[0].img;
                                var name = listDestination![index].name;
                                return InkWell(
                                  onTap: () {
                                    loginChecker
                                        ? Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailDestinationUser(
                                                      destinationId: id,
                                                    )))
                                        : Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailDestination(
                                                      destinationId: id,
                                                    )));
                                  },
                                  child: WishlistDestinationCard(
                                      image: img,
                                      title: name,
                                      rating: rating,
                                      place: address),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text('Not Logged In'),
                          ),
                    loginChecker
                        ? Visibility(
                            visible: isLoadedPack,
                            replacement:
                                const Center(child: Text('Wishlist Empty')),
                            child: ListView.builder(
                              itemCount: listPackageTrip?.length,
                              itemBuilder: (context, index) {
                                var title = listPackageTrip![index].name;
                                var img = listPackageTrip![index].images[0].img;
                                var rating = double.parse(
                                    listPackageTrip![index].rating.toString());
                                var price = listPackageTrip![index].price;
                                var id = listPackageTrip![index].id;
                                return InkWell(
                                  onTap: () {
                                    loginChecker
                                        ? Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailPackageTripUser(
                                                        packageTripId: id)))
                                        : Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    DetailPackageTrip(
                                                        packageTripId: id)));
                                  },
                                  child: PackageTripCard(
                                    title,
                                    img,
                                    price,
                                    rating,
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text('Not Logged In'),
                          )
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
