import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/listapi.dart';
import 'package:wisata_bali/detailpage/detail_packagetrip_user.dart';
import 'package:wisata_bali/detailpage/detailpackagetrip.dart';
import 'package:wisata_bali/models/list_package_trip_model.dart';
import 'package:wisata_bali/widgets/packagetripcard.dart';

class PackageTrip extends StatefulWidget {
  const PackageTrip({Key? key}) : super(key: key);

  @override
  State<PackageTrip> createState() => _PackageTripState();
}

class _PackageTripState extends State<PackageTrip> {
  List<ListPackageTripModel>? listAllPackageTrips;
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
      print(loginChecker);
    }
    print(prefs.getString('jwt'));
  }

  var isLoaded = false;
  getAllData() async {
    listAllPackageTrips = await ListApi().listAllPackageTrip();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    getAllData();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Package Trip',
                          style: GoogleFonts.salsa(
                              fontSize: 36,
                              textStyle: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 2,
                          color: isDarkTheme ? Colors.white : Colors.black))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Visibility(
                visible: isLoaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: listAllPackageTrips?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          loginChecker
                              ? Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => DetailPackageTripUser(
                                        packageTripId:
                                            listAllPackageTrips![index].id,
                                      )))
                              : Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => DetailPackageTrip(
                                        packageTripId:
                                            listAllPackageTrips![index].id,
                                      )));
                        },
                        child: PackageTripCard(
                            listAllPackageTrips![index].name,
                            listAllPackageTrips![index].images[0].img,
                            listAllPackageTrips![index].price,
                            double.parse(
                                listAllPackageTrips![index].rating.toString())),
                      );
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
