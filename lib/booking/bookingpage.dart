import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';
import 'package:wisata_bali/widgets/packagetripcard.dart';

class BookingPage extends StatefulWidget {
  final String title;
  final String rating;
  final String price;
  final String image;
  const BookingPage(
      {super.key,
      required this.title,
      required this.rating,
      required this.price,
      required this.image});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final currencyformatter = NumberFormat.currency(locale: 'ID', symbol: 'Rp. ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
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
                  Container(
                    width: 200,
                    height: 59,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text('INI ADALAH TANGGAL')),
                  ),
                  Container(
                    width: 150,
                    height: 59,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
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
                        const Text(
                          '2',
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {},
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
                    border: Border.all(width: 1, color: Colors.black),
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
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff136068),
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'INI BUAT TANGGAL',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff136068)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pickup Point',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff136068),
                            ),
                          ),
                          Text(
                            'Ngurah Rai Airport',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff136068)),
                          ),
                          Text(
                            '10.00 WITA',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff136068)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2 Pax x ${currencyformatter.format(int.parse(widget.price))}/pax',
                            style: const TextStyle(
                                color: Color(0xff136068), fontSize: 16),
                          ),
                          Text(
                            '${currencyformatter.format(int.parse(widget.price))}/pax',
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color(0xff136068),
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
                onTap: () {},
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
