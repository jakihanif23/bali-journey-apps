import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/widgets/givereviewsbutton.dart';
import 'package:wisata_bali/widgets/login_button.dart';

class DetailDestination extends StatefulWidget {
  final int destinationId;
  final String image;

  const DetailDestination(
      {Key? key, required this.destinationId, required this.image})
      : super(key: key);

  @override
  State<DetailDestination> createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 380,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              color: Colors.white.withOpacity(0.1),
              child: Text(
                'Destination ${widget.destinationId}',
                style: TextStyle(color: Colors.black),
              ),
            ),
            background: Image.asset(
              '${widget.image}',
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
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi at magna vitae massa porta semper quis vitae tortor. In finibus ligula eu nunc porttitor, sed aliquet leo hendrerit. Cras orci ex, hendrerit nec augue ut, faucibus tincidunt nisi. Vestibulum quis lectus vel lorem interdum lobortis et non ligula. Nam fermentum odio in odio molestie pulvinar. In venenatis magna eget est egestas, eget mattis quam molestie. Integer pharetra, arcu a suscipit ullamcorper, arcu odio ultricies leo, vitae ullamcorper lectus tortor a dui. Ut efficitur velit a nulla malesuada, non maximus lacus sollicitudin. Nulla et arcu vel lectus tempus porta. Nam posuere ullamcorper lacus quis consectetur. Aliquam in sodales sem, eu auctor magna. Sed vel est sollicitudin, viverra lectus quis, volutpat arcu. Aliquam dapibus consequat metus, hendrerit tincidunt ante lobortis id. Praesent cursus diam tellus, aliquet ullamcorper elit venenatis vitae.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 2),
                        bottom: BorderSide(width: 2))),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Open From :',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '9:00 AM - 17:00 PM',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('Monday - Sunday')
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GiveReviewButton(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reviews',
                      style: GoogleFonts.salsa(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          width: 377,
                          height: 191,
                          decoration: BoxDecoration(
                              color: Color(0xffD9F9F8),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                                  AssetImage('assets/man.jpg'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Mamang Kesbor',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text(
                                                    'New Delhi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                          'Bintang di surga'))
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '20 Desember 2021',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontStyle: FontStyle.italic
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text('lorem ipsum dolor sit amet'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
