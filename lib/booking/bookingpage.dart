import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/mainpage.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';
import 'package:wisata_bali/widgets/packagetripcard.dart';

class BookingPage extends StatefulWidget {
  final String title;
  final String rating;
  final String price;
  final String image;
  final String id;
  const BookingPage(
      {super.key,
      required this.title,
      required this.rating,
      required this.price,
      required this.image,
      required this.id});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  int index = 1;
  final currencyformatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 8))))) {
      return true;
    }
    return false;
  }

  __selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        helpText: 'Select Booking Date',
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2022),
        lastDate: DateTime(2023),
        selectableDayPredicate: _decideWhichDayToEnable);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  startBooking(String date, String id, String amount) async {
    var prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    const String apiUrl =
        'https://api-bali-journey.herokuapp.com/users/payments/carts';
    var response = await http.post(Uri.parse(apiUrl),
        body: {'date': date, 'package_tripId': id, 'amount': amount},
        headers: {'access_token': getString.toString()});
    if (response.statusCode == 201) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Booking Success'),
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
    } else if (response.statusCode == 203) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Booking Failed'),
            content: const Text('Please choose another day'),
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
            title: const Text('Booking Failed'),
            content: const Text('Error Encountered when booking'),
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
    var pricing = currencyformatter.format(int.parse(widget.price));
    var total = index * int.parse(widget.price);
    var currencyTotal = currencyformatter.format(int.parse(total.toString()));
    var datetime = '${selectedDate.toLocal()}'.split(' ')[0];
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
                child: Stack(
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
                    Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        alignment: Alignment.center,
                        width: 280,
                        height: 50,
                        child: Center(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: PackageTripCard(widget.title, widget.image, widget.price,
                    double.parse(widget.price)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => __selectDate(context),
                    child: Container(
                      width: 200,
                      height: 59,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isDarkTheme ? Colors.white : Colors.black,
                              width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        datetime,
                        style: const TextStyle(fontSize: 20),
                      )),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 59,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (index > 1) {
                                index -= 1;
                              } else {
                                index = 1;
                              }
                            });
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: 20,
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.person),
                        Text(
                          index.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (index < 8) {
                                index += 1;
                              } else {
                                index = 8;
                              }
                            });
                          },
                          child: SizedBox(
                            width: 20,
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 200,
                width: 380,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: isDarkTheme ? Colors.white : Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            datetime,
                            style: TextStyle(
                                fontSize: 14,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup Point',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff136068),
                            ),
                          ),
                          Text(
                            'Ngurah Rai Airport',
                            style: TextStyle(
                                fontSize: 14,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068)),
                          ),
                          Text(
                            '10.00 WITA',
                            style: TextStyle(
                                fontSize: 14,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$index Pax x $pricing/pax',
                            style: TextStyle(
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068),
                                fontSize: 16),
                          ),
                          Text(
                            '$currencyTotal/pax',
                            style: TextStyle(
                                fontSize: 25,
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  // print(datetime);
                  // print(widget.id);
                  // print(index);
                  startBooking(datetime, widget.id, index.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const ButtonYellow(title: 'Save')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
