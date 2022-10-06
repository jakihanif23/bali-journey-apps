import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/homeapi.dart';
import 'package:wisata_bali/models/destination_model.dart';
import 'package:wisata_bali/widgets/destinationreviewscard.dart';
import 'package:wisata_bali/widgets/givereviewsbutton.dart';

class DetailDestination extends StatefulWidget {
  final int destinationId;

  const DetailDestination({
    Key? key,
    required this.destinationId,
  }) : super(key: key);

  @override
  State<DetailDestination> createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  late Future<DestinationModel> futureDestination;
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
    futureDestination = HomeApi().getDataDestination(widget.destinationId);
  }

  final TextEditingController _reviewController = TextEditingController();
  double ratingIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: FutureBuilder<DestinationModel>(
            future: futureDestination,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var name = snapshot.data!.name;
                var rating = double.parse(snapshot.data!.rating.toString());
                var deskripsi = snapshot.data!.description;
                var address = snapshot.data!.address;
                var opentime = snapshot.data!.openTime;
                var openday = snapshot.data!.openDay;
                var image = snapshot.data!.images[0].img;
                var reviews = snapshot.data!.reviews;
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                          isDarkTheme ? Colors.black87 : Colors.white,
                      pinned: true,
                      expandedHeight: 380,
                      leading: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: isDarkTheme ? Colors.grey : Colors.black,
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        title: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: Text(
                            name,
                            style: TextStyle(
                                color:
                                    isDarkTheme ? Colors.white : Colors.black),
                          ),
                        ),
                        background: Image.network(
                          'http://10.0.2.2:3000/$image',
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                      centerTitle: true,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              deskripsi,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(width: 2),
                                    bottom: BorderSide(width: 2))),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Open From :',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            opentime,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(openday)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (loginChecker == false) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: ((context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Alert Reviews'),
                                                  content: const Text(
                                                      'You Are not Logged in'),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('Ok'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }));
                                        } else {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: SizedBox(
                                                    height: 400,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 20, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Review',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Color(
                                                                        0xff136068),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    _reviewController,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff136068)),
                                                                decoration:
                                                                    InputDecoration(
                                                                  fillColor:
                                                                      const Color(
                                                                          0xffD9F9F8),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Color(0xff136068))),
                                                                  hintText:
                                                                      'Review',
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              RatingBar.builder(
                                                                initialRating:
                                                                    ratingIndex,
                                                                minRating: 1,
                                                                updateOnDrag:
                                                                    true,
                                                                itemBuilder: ((context,
                                                                        index) =>
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    )),
                                                                onRatingUpdate:
                                                                    (rating) =>
                                                                        setState(
                                                                            () {
                                                                  ratingIndex =
                                                                      rating;
                                                                  print(
                                                                      ratingIndex);
                                                                }),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  'Rating $ratingIndex'),
                                                              InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      ratingIndex);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'enter'),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }
                                      },
                                      child: const GiveReviewButton(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
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
                                  height: 300,
                                  child: reviews.isEmpty
                                      ? const Center(
                                          child: Text('No Reviews'),
                                        )
                                      : ListView.builder(
                                          itemCount: reviews.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 10, 0),
                                                child: Column(
                                                  children: const [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    DestinationReviewCard()
                                                  ],
                                                ));
                                          },
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('No Data'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
