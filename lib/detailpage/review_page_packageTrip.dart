import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_bali/apiservices/userapi.dart';
import 'package:wisata_bali/widgets/givereviewsbutton.dart';

import '../mainpage.dart';
import '../models/detail_packagetrip_user_model.dart';
import '../widgets/review_packagetrip_detail_card.dart';

class ReviewPackageTrip extends StatefulWidget {
  final String name;
  final double rating;
  final String price;
  final String id;
  final String image;
  const ReviewPackageTrip(
      {super.key,
      required this.id,
      required this.price,
      required this.name,
      required this.rating,
      required this.image});

  @override
  State<ReviewPackageTrip> createState() => _ReviewPackageTripState();
}

class _ReviewPackageTripState extends State<ReviewPackageTrip> {
  Future<DetailPackageTripUserModel>? futuredata;

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
      futuredata = UserApi().getPackageTrip(int.parse(widget.id));
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  final TextEditingController _reviewController = TextEditingController();
  double ratingIndex = 1;
  // File? imageFile;
  // Future getImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   imageFile = File(pickedFile!.path);
  //   setState(() {});
  // }

  giveReview(String review, double rating, String id) async {
    final prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt').toString();
    final String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/detail/pack/review/$id';
    var response = await http.post(Uri.parse(apiUrl),
        headers: {'access_token': getString},
        body: {'comment': review, 'rating': rating.toString()});
    if (response.statusCode == 201 && _reviewController.text != '') {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Review Success'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (builder) => HomePage()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text('OK'))
            ],
          );
        },
      );
    } else if (response.statusCode == 200) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Review Failed'),
            content: const Text('You Have given a Review before'),
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
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Review Failed'),
            content: const Text('You already have been Give a Review'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                              ),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Give Review',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ReviewPackageTripDetailCard(
                                title: widget.name,
                                rating: widget.rating,
                                price: int.parse(widget.price),
                                image: widget.image,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Review',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: isDarkTheme
                                        ? Colors.white
                                        : const Color(0xff136068),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: TextField(
                                controller: _reviewController,
                                style: TextStyle(
                                    color: isDarkTheme
                                        ? Colors.white
                                        : const Color(0xff136068)),
                                decoration: InputDecoration(
                                  fillColor: const Color(0xffD9F9F8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Color(0xff136068))),
                                  hintText: 'Review',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: RatingBar.builder(
                                initialRating: ratingIndex,
                                minRating: 1,
                                allowHalfRating: true,
                                updateOnDrag: true,
                                itemBuilder: ((context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )),
                                onRatingUpdate: (rating) => setState(() {
                                  ratingIndex = rating;
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Text(
                              'Rating $ratingIndex',
                              style: const TextStyle(fontSize: 20),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: InkWell(
                                      onTap: () {
                                        giveReview(_reviewController.text,
                                            ratingIndex, widget.id);
                                      },
                                      child: const GiveReviewButton()),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
