import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/detailpage/detaildestination_user.dart';
import 'package:wisata_bali/models/list_destination_model.dart';
import 'package:wisata_bali/widgets/searchcard.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ListDestinationModel> listData = [];
  List<ListDestinationModel> listData2 = [];
  String url = 'https://api-bali-journey.herokuapp.com/home/allDestinations';
  static List<ListDestinationModel> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ListDestinationModel>(
            (json) => ListDestinationModel.fromJson(json))
        .toList();
  }

  Future<List<ListDestinationModel>> getAllLists() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<ListDestinationModel> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception('Error');
    }
  }

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
    print(prefs.getString('jwt'));
  }

  @override
  void initState() {
    checkLogin();
    getAllLists().then((value) => {
          setState(() {
            listData = value;
            listData2 = listData;
          })
        });
    super.initState();
  }

  void updateList(String value) {
    setState(() {
      listData2 = listData
          .where((element) =>
              (element.name.toLowerCase().contains(value.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: const Text(
                      'Search Destination',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    onChanged: (value) => updateList(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: isDarkTheme
                          ? Colors.black26
                          : const Color(0xffD9F9F8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none),
                      hintText: 'eg: Pantai Kuta',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(width: 2))),
                  child: listData2.isEmpty
                      ? const Center(
                          child: Text(
                            'Result not Found',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listData2.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                loginChecker
                                    ? Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                DetailDestinationUser(
                                                  destinationId:
                                                      listData2[index].id,
                                                )))
                                    : Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                DetailDestination(
                                                  destinationId:
                                                      listData2[index].id,
                                                )));
                              },
                              child: SearchCard(
                                category: listData2[index].category.name,
                                title: listData2[index].name,
                                rating: listData2[index].rating.toDouble(),
                                location: listData2[index].address,
                                image: listData2[index].images[0].img,
                              ),
                            );
                          },
                        )),
            )
          ],
        ),
      ),
    );
  }
}
