import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wisata_bali/models/listmodels.dart';
import 'package:wisata_bali/widgets/searchcard.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static List<SearchCardList> searchList = [
    SearchCardList('Bali', 'assets/bg.jpg', 'Snorkling, Surfing, Diving',
        'Bali Barat', 3.0),
    SearchCardList('Pantai Kuta', 'assets/beach.jpg',
        'Snorkling, Surfing, Diving', 'Bali Timur', 2.1),
    SearchCardList(
        'Gunung Aja', 'assets/bg.jpg', 'Hiking, Nyantai', 'Bali Ujung', 3.4),
    SearchCardList(
        'Pegunungan', 'assets/beach.jpg', 'Jalan Jalan', 'Bali Barat', 4.4),
    SearchCardList('Next Trip', 'assets/bg.jpg', 'Kesana aja sih maunya',
        'Bali Barat', 4.1),
  ];

  List<SearchCardList> displayList = List.from(searchList);

  void updateList(String value) {
    setState(() {
      displayList = searchList
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: MediaQuery.of(context).size.width,
                height: 150,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Search Destination',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (value) => updateList(value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: isDarkTheme?Colors.black26:Color(0xffD9F9F8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none),
                        hintText: 'eg: Pantai Kuta',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 2))),
                    child: displayList.length == 0
                        ? Center(
                            child: Text(
                              'Result not Found',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              return SearchCard(
                                type: displayList[index].type,
                                title: displayList[index].title,
                                rating: displayList[index].rating,
                                location: displayList[index].location,
                                image: displayList[index].image,
                              );
                            },
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
