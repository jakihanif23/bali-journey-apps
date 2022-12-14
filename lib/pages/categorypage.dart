import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/listapi.dart';
import 'package:wisata_bali/detailpage/detaildestination.dart';
import 'package:wisata_bali/detailpage/detaildestination_user.dart';
import 'package:wisata_bali/models/list_destination_model.dart';
import 'package:wisata_bali/widgets/card.dart';

class CategoryPage extends StatefulWidget {
  final int cateId;
  final String title;
  const CategoryPage({Key? key, required this.cateId, required this.title})
      : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ListDestinationModel>? listDestinations;
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

  var isLoaded = false;
  getAllData() async {
    listDestinations =
        await ListApi().listAllDestinationsbyCategory(widget.cateId);

    if (listDestinations != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.salsa(
                            fontSize: 36,
                            textStyle: TextStyle(
                                color: isDarkTheme
                                    ? Colors.white
                                    : const Color(0xff136068))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          'All ${widget.title}',
                          style: GoogleFonts.salsa(
                              fontSize: 24,
                              textStyle: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068))),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                          height: 300,
                          child: Visibility(
                            visible: isLoaded,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listDestinations?.length,
                              itemBuilder: (context, index) {
                                return listDestinations!.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 20, 0),
                                        child: InkWell(
                                          onTap: () {
                                            print(listDestinations![index].id);
                                            loginChecker
                                                ? Navigator.of(context).push(
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            DetailDestinationUser(
                                                              destinationId:
                                                                  listDestinations![
                                                                          index]
                                                                      .id,
                                                            )))
                                                : Navigator.of(context).push(
                                                    CupertinoPageRoute(
                                                        builder: (context) =>
                                                            DetailDestination(
                                                              destinationId:
                                                                  listDestinations![
                                                                          index]
                                                                      .id,
                                                            )));
                                          },
                                          child: CardWidgets(
                                              listDestinations![index]
                                                  .images[0]
                                                  .img,
                                              listDestinations![index].name),
                                        ),
                                      );
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          'Recommended ${widget.title}',
                          style: GoogleFonts.salsa(
                              fontSize: 24,
                              textStyle: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068))),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                          height: 300,
                          child: Visibility(
                            visible: isLoaded,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: listDestinations?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: InkWell(
                                    onTap: () {
                                      loginChecker
                                          ? Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      DetailDestinationUser(
                                                        destinationId:
                                                            listDestinations![
                                                                    index]
                                                                .id,
                                                      )))
                                          : Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      DetailDestination(
                                                        destinationId:
                                                            listDestinations![
                                                                    index]
                                                                .id,
                                                      )));
                                    },
                                    child: CardWidgets(
                                        listDestinations![index].images[0].img,
                                        listDestinations![index].name),
                                  ),
                                );
                              },
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
