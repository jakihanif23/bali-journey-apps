import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/models/profile_model.dart';

import '../apiservices/userapi.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  _nameController.text = name ?? '';
                  _emailController.text = email ?? '';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Edit Account',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage('http://10.0.2.2:3000/$image'),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 58,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 3,
                                      color: const Color(0xff136068))),
                              child: const Center(
                                child: Text(
                                  'Change Picture',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff136068)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _nameController,
                              style: const TextStyle(color: Color(0xff136068)),
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9F9F8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff136068))),
                                hintText: 'Name',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Color(0xff136068)),
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9F9F8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff136068))),
                                hintText: 'Email',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _passwordController,
                              style: const TextStyle(color: Color(0xff136068)),
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9F9F8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff136068))),
                                hintText: 'Input Password',
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 42,
                            width: 352,
                            decoration: BoxDecoration(
                                color: const Color(0xffFCE40C),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              'Save',
                              style: GoogleFonts.salsa(fontSize: 12),
                            )),
                          ),
                        ),
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
