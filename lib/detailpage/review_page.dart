import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/mainpage.dart';
import 'package:wisata_bali/widgets/givereviewsbutton.dart';
import 'package:wisata_bali/widgets/searchcard.dart';

class ReviewPage extends StatefulWidget {
  final String name;
  final double rating;
  final String category;
  final String address;
  final String id;
  final String image;
  const ReviewPage(
      {super.key,
      required this.id,
      required this.address,
      required this.category,
      required this.name,
      required this.rating,
      required this.image});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  double ratingIndex = 1;
  giveReview(String review, double rating, String id) async {
    final prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt').toString();
    final String apiUrl = 'http://10.0.2.2:3000/users/detail/dest/review/$id';
    var response = await http.post(Uri.parse(apiUrl),
        headers: {'access_token': getString},
        body: {'comment': review, 'rating': rating.toString()});
    if (response.statusCode == 201) {
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
            content: const Text('Already Give Review'),
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
            content: const Text('Review Failed Encountered'),
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
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Give Review',
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
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SearchCard(
                          category: widget.category,
                          title: widget.name,
                          rating: widget.rating,
                          location: widget.address,
                          image: widget.image,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Review',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff136068),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _reviewController,
                        style: const TextStyle(color: Color(0xff136068)),
                        decoration: InputDecoration(
                          fillColor: const Color(0xffD9F9F8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xff136068))),
                          hintText: 'Review',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RatingBar.builder(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Rating $ratingIndex'),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          onTap: () {
                            giveReview(
                                _reviewController.text, ratingIndex, widget.id);
                          },
                          child: const GiveReviewButton())
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
