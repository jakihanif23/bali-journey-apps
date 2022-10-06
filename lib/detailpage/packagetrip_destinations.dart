import 'package:flutter/material.dart';
import 'package:wisata_bali/apiservices/homeapi.dart';
import 'package:wisata_bali/models/packagetripmodel.dart';
import 'package:wisata_bali/widgets/wishlistdestinationcard.dart';

class PackageTripDestinations extends StatefulWidget {
  final int packageTripId;

  const PackageTripDestinations({
    Key? key,
    required this.packageTripId,
  }) : super(key: key);

  @override
  State<PackageTripDestinations> createState() =>
      _PackageTripDestinationsState();
}

class _PackageTripDestinationsState extends State<PackageTripDestinations> {
  late Future<PackageTripModel> futuredata;
  @override
  void initState() {
    super.initState();
    futuredata = HomeApi().getDataPackageTrip(widget.packageTripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<PackageTripModel>(
            future: futuredata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Package Trip Details ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trip Destination',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: snapshot.data!.destinations.isEmpty
                                    ? const Center(
                                        child: Text('No Destinations Added'),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  snapshot.data!.destinations
                                                      .length;
                                              i++)
                                            Text(
                                                ' ● ${snapshot.data!.destinations[i]['name']}')
                                        ],
                                      )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 400,
                                child: snapshot.data!.destinations.isEmpty
                                    ? const Center(
                                        child: Text('Data 0'),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            snapshot.data!.destinations.length,
                                        itemBuilder: ((context, index) {
                                          var destinasi =
                                              snapshot.data!.destinations;
                                          if (snapshot
                                              .data!.destinations.isEmpty) {
                                            return const Center(
                                              child: Text('No Data'),
                                            );
                                          } else {
                                            return WishlistDestinationCard(
                                                image: destinasi[index]
                                                    ['images'][0]['img'],
                                                title: destinasi[index]['name'],
                                                rating: double.parse(
                                                    destinasi[index]['rating']
                                                        .toString()),
                                                place: destinasi[index]
                                                    ['address']);
                                          }
                                        }),
                                      ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
