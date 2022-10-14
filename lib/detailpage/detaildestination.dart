import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/homeapi.dart';
import 'package:wisata_bali/detailpage/review_page.dart';
import 'package:wisata_bali/icons/custom_icons_icons.dart';
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
                var id = snapshot.data!.id;
                var category = snapshot.data!.category.name;
                var address = snapshot.data!.address;
                var opentime = snapshot.data!.openTime;
                var openday = snapshot.data!.openDay;
                var image = snapshot.data!.images[0].img;
                var reviews = snapshot.data!.reviews;
                var mapLink = snapshot.data!.mapLink;
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 380,
                          backgroundColor:
                              isDarkTheme ? Colors.black : Colors.white,
                          leading: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: isDarkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            title: Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                  color: isDarkTheme
                                      ? Colors.black12
                                      : Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                name,
                                style: TextStyle(
                                  color:
                                      isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            background: Image.network(
                              'https://api-bali-journey.herokuapp.com/$image',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: RatingBarIndicator(
                                    rating: double.parse(rating.toString()),
                                    itemCount: 5,
                                    itemSize: 30,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Rating ${rating.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
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
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 2,
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black),
                                        bottom: BorderSide(
                                            width: 2,
                                            color: isDarkTheme
                                                ? Colors.white
                                                : Colors.black))),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                          child:
                                                              const Text('Ok'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  }));
                                            } else {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(CupertinoPageRoute(
                                                      builder: (builder) =>
                                                          ReviewPage(
                                                            id: id.toString(),
                                                            image: image,
                                                            address: address,
                                                            name: name,
                                                            category: category,
                                                            rating: rating,
                                                          )));
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
                                                var comment =
                                                    reviews[index]['comment'];
                                                var rating = double.parse(
                                                    reviews[index]['rating']
                                                        .toString());
                                                var userName = reviews[index]
                                                    ['user']['name'];
                                                var image = reviews[index]
                                                    ['user']['images'];
                                                return Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 10, 0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        DestinationReviewCard(
                                                          image: image,
                                                          name: userName,
                                                          rating: rating,
                                                          comment: comment,
                                                        )
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
                    ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            showAnimatedDialog(
                              context: context,
                              barrierDismissible: true,
                              animationType:
                                  DialogTransitionType.slideFromBottomFade,
                              curve: Curves.ease,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Add Wishlist Failed'),
                                  content: const Text('You have to Logged in'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'))
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  color: Color(0xffEDEDED),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                CustomIcons.heart,
                                size: 30,
                              )),
                        ))
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
