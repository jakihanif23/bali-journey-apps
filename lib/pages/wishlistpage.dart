import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/userapi.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/models/profile_model.dart';
import 'package:wisata_bali/pages/accountpage.dart';
import 'package:wisata_bali/widgets/wishlistdestinationcard.dart';
import 'package:wisata_bali/widgets/wishlistpackagetripcard.dart';

import 'accountpageloggedin.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> with TickerProviderStateMixin {
  late Future<UserModel> futureUser;
  var loginChecker = false;
  checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('jwt') == null) {
      print('user null');
    } else {
      setState(() {
        loginChecker = true;
      });
      String data = prefs.getString('jwt') ?? '';
      futureUser = UserApi().getProfileData(data);
      // Map<String, dynamic> payload = Jwt.parseJwt(data);
      // // print(prefs.getString('jwt'));
      // var id = payload['id'];
      // const String apiUrl = 'http://10.0.2.2:3000/users/profile';
      // final response = await http.get(Uri.parse(apiUrl), headers: {
      //   'access_token': '${prefs.getString('jwt')}',
      // });
      // print(response.body);
      // print(payload);
      print(loginChecker);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
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
                    loginChecker
                        ? FutureBuilder<UserModel>(
                            future: futureUser,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const AccountPageLoggedIn()));
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          'http://10.0.2.2:3000/${snapshot.data!.img}'),
                                    ),
                                  ),
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => const Account()));
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage('assets/man.jpg'),
                                  ),
                                ),
                              );
                            })
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => const Account()));
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
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
                    loginChecker
                        ? ListView.builder(
                            itemCount: ratingnilai.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => DetailDestination(
                                          destinationId: index)));
                                },
                                child: WishlistDestinationCard(
                                    image: 'assets/bg.jpg',
                                    title: 'Title $index',
                                    rating: ratingnilai[index],
                                    place: 'place $index'),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Not Logged In'),
                          ),
                    loginChecker
                        ? ListView.builder(
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
