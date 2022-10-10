import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/apiservices/userapi.dart';
import 'package:wisata_bali/pages/edit_profile_page.dart';

import '../models/profile_model.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Future<UserModel>? futureUser;
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
      futureUser = UserApi().getProfileData(data);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<UserModel>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var image = snapshot.data?.img;
                  var name = snapshot.data?.name;
                  var email = snapshot.data?.email;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color:
                                      isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'My Account',
                                  style: TextStyle(
                                      color: isDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                        child: CircleAvatar(
                          radius: 116,
                          backgroundImage: NetworkImage(
                              'https://api-bali-journey.herokuapp.com/$image'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            '$name',
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$email',
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage()));
                            },
                            child: Container(
                              width: 238,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: isDarkTheme
                                          ? Colors.white
                                          : const Color(0xff136068),
                                      width: 3)),
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: isDarkTheme
                                        ? Colors.white
                                        : const Color(0xff136068),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No Account'),
                  );
                }
              }),
        ),
      ),
    );
  }
}
