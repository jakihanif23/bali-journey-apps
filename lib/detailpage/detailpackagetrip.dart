import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/widgets/buttonyellow.dart';
import 'package:wisata_bali/widgets/destinationreviewscard.dart';
import 'package:wisata_bali/widgets/packagetripreviewcard.dart';

class DetailPackageTrip extends StatefulWidget {
  final int packageTripId;
  final String image;

  const DetailPackageTrip(
      {Key? key, required this.packageTripId, required this.image})
      : super(key: key);

  @override
  State<DetailPackageTrip> createState() => _DetailPackageTripState();
}

class _DetailPackageTripState extends State<DetailPackageTrip> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Stack(
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
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Container(
                    color: Colors.white.withOpacity(0.1),
                    child: Text(
                      'Package Trip ${widget.packageTripId}',
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
                child: Container(
                  padding: EdgeInsets.only(bottom: 90),
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
                      InkWell(
                        onTap: (){},
                        child: Container(
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: isDarkTheme?Colors.white:Colors.black),
                                    bottom: BorderSide(color: isDarkTheme?Colors.white:Colors.black)
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Trip Destination',
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkTheme ? Colors.white :Color(0xff136068)
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: SvgPicture.asset('assets/arrow_top_right.svg', color: isDarkTheme?Colors.white:Color(0xff136068),),
                                )
                              ],
                            )
                        ),
                      ),
                      SizedBox(height: 1,),
                      InkWell(
                        onTap: (){},
                        child: Container(
                            height: 90,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(color: isDarkTheme?Colors.white:Colors.black),
                                    bottom: BorderSide(color: isDarkTheme?Colors.white:Colors.black)
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    'Details',
                                    style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: isDarkTheme?Colors.white:Color(0xff136068)
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: SvgPicture.asset('assets/arrow_top_right.svg', color: isDarkTheme?Colors.white:Color(0xff136068),),
                                )
                              ],
                            )
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reviews',
                              style: GoogleFonts.salsa(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 377,
                              child: ListView.builder(
                                itemCount: 5,
                                itemBuilder: (context, index){
                                  return Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10,),
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
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.only(left: 20, right: 20),
              color: Color(0xffD7F8D7),
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
                          Text(
                            'From',
                            style: TextStyle(
                                color: Color(0xff136068),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'IDR 1,500,000 /pax',
                            style: TextStyle(
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
                      child: ButtonYellow(title: 'Booking'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
