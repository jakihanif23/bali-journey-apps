import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/categoryapi.dart';
import 'package:wisata_bali/apiservices/homeapi.dart';
import 'package:wisata_bali/apiservices/userapi.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/detailpage/detaildestination_user.dart';
import 'package:wisata_bali/detailpage/detailpackagetrip.dart';
import 'package:wisata_bali/models/category.dart';
import 'package:wisata_bali/models/homemodel.dart';
import 'package:wisata_bali/models/profile_model.dart';
import 'package:wisata_bali/pages/accountpage.dart';
import 'package:wisata_bali/pages/accountpageloggedin.dart';
import 'package:wisata_bali/pages/categorypage.dart';
import 'package:wisata_bali/widgets/card.dart';
import 'package:wisata_bali/widgets/category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<HomeModel> futureHome;
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
    print(prefs.getString('jwt'));
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    getData();
    futureHome = HomeApi().getHomeApi();
  }

  List<CategoryModel>? categories;
  var isLoaded = false;
  getData() async {
    categories = await CategoryApi().listCategories();
    if (categories != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Your',
                          style: GoogleFonts.salsa(
                              fontSize: 36,
                              textStyle: TextStyle(
                                  color: isDarkTheme
                                      ? const Color(0xffD9F9F8)
                                      : const Color(0xff136068))),
                        ),
                        Text(
                          'Destination',
                          style: GoogleFonts.salsa(
                              fontSize: 36,
                              textStyle: TextStyle(
                                  color: isDarkTheme
                                      ? const Color(0xffD9F9F8)
                                      : const Color(0xff136068))),
                        )
                      ],
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
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 20, 0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://api-bali-journey.herokuapp.com/${snapshot.data!.img}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        height: 60,
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: Image.asset('assets/man.jpg'),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/man.jpg'),
                                    ),
                                  ));
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
                                  backgroundImage: AssetImage('assets/man.jpg'),
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
                        ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              height: 80,
              child: Container(
                  child: Visibility(
                visible: isLoaded,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CategoryPage(
                                      title: categories![index].name,
                                      cateId: categories![index].id)));
                        },
                        child: CategoryWidgets(categories![index].name),
                      ),
                    );
                  },
                ),
              )),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text(
                'Recommendation Destination',
                style: GoogleFonts.salsa(
                    fontSize: 24,
                    textStyle: TextStyle(
                        color: isDarkTheme
                            ? const Color(0xffD9F9F8)
                            : const Color(0xff136068))),
              ),
            ),

            //Go To Destination Page
            Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                height: 300,
                child: FutureBuilder<HomeModel>(
                    future: futureHome,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var destination = snapshot.data!.recDest;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destination.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: InkWell(
                                onTap: () {
                                  loginChecker
                                      ? Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  DetailDestinationUser(
                                                    destinationId:
                                                        destination[index].id,
                                                  )))
                                      : Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  DetailDestination(
                                                    destinationId:
                                                        destination[index].id,
                                                  )));
                                },
                                child: CardWidgets(
                                    destination[index].images[0].img,
                                    destination[index].name),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text(
                'Recommendation Package Trip',
                style: GoogleFonts.salsa(
                    fontSize: 24,
                    textStyle: TextStyle(
                        color: isDarkTheme
                            ? const Color(0xffD9F9F8)
                            : const Color(0xff136068))),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              height: 300,
              child: FutureBuilder<HomeModel>(
                  future: futureHome,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var package = snapshot.data!.recPackage;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: package.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => DetailPackageTrip(
                                          packageTripId: package[index].id,
                                        )));
                              },
                              child: CardWidgets(package[index].images[0].img,
                                  package[index].name),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
