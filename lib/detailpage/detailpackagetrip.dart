import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wisata_bali/apiservices/homeapi.dart';
import 'package:wisata_bali/models/packagetripmodel.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';
import 'package:wisata_bali/widgets/packagetripreviewcard.dart';

class DetailPackageTrip extends StatefulWidget {
  final int packageTripId;

  const DetailPackageTrip({
    Key? key,
    required this.packageTripId,
  }) : super(key: key);

  @override
  State<DetailPackageTrip> createState() => _DetailPackageTripState();
}

class _DetailPackageTripState extends State<DetailPackageTrip> {
  late Future<PackageTripModel> futuredata;

  @override
  void initState() {
    super.initState();
    futuredata = HomeApi().getDataPackageTrip(widget.packageTripId);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: FutureBuilder<PackageTripModel>(
      future: futuredata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var name = snapshot.data!.name;
          var description = snapshot.data!.description;
          var price = snapshot.data!.price;
          final currencyformatter =
              NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
          var rating = snapshot.data!.rating;
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    expandedHeight: 380,
                    leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Container(
                        color: Colors.white.withOpacity(0.1),
                        child: Text(
                          name,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      background: Image.network(
                        'http://10.0.2.2:3000/${snapshot.data!.images[0].img.toString()}',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: RatingBarIndicator(
                                rating: double.parse(rating.toString()),
                                itemCount: 5,
                                itemSize: 30,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068),
                                ),
                              )),
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return snapshot.data!.destinations.isEmpty
                                        ? const SizedBox(
                                            height: 200,
                                            child: Center(
                                                child: Text('No Destination')),
                                          )
                                        : const SizedBox(
                                            height: 400,
                                            child: Center(
                                              child:
                                                  Text('ini Trip Destination'),
                                            ),
                                          );
                                  });
                            },
                            child: Container(
                                height: 90,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black),
                                        bottom: BorderSide(
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'Trip Destination',
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkTheme
                                                ? Colors.white
                                                : const Color(0xff136068)),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: SvgPicture.asset(
                                        'assets/arrow_top_right.svg',
                                        color: isDarkTheme
                                            ? Colors.white
                                            : const Color(0xff136068),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const SizedBox(
                                      height: 400,
                                      child: Center(
                                        child: Text('ini Details'),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                height: 90,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black),
                                        bottom: BorderSide(
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'Details',
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: isDarkTheme
                                                ? Colors.white
                                                : const Color(0xff136068)),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: SvgPicture.asset(
                                        'assets/arrow_top_right.svg',
                                        color: isDarkTheme
                                            ? Colors.white
                                            : const Color(0xff136068),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reviews',
                                  style: GoogleFonts.salsa(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 377,
                                  child: snapshot.data!.reviews.isEmpty
                                      ? const Center(
                                          child: Text('Reviews 0'),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              snapshot.data!.reviews.length,
                                          itemBuilder: (context, index) {
                                            return snapshot
                                                    .data!.reviews.isEmpty
                                                ? const Center(
                                                    child:
                                                        PackageTripReviewCard())
                                                : Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 10, 0),
                                                    child: Column(
                                                      children: const [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        PackageTripReviewCard()
                                                      ],
                                                    ),
                                                  );
                                          },
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  color: const Color(0xffD7F8D7),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'From',
                                style: TextStyle(
                                    color: Color(0xff136068),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${currencyformatter.format(int.parse(price))}/pax',
                                style: const TextStyle(
                                    color: Color(0xff136068),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: const ButtonYellow(title: 'Booking'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Data Not Found'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
