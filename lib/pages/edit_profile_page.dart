import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/mainpage.dart';
import 'package:wisata_bali/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';

import '../apiservices/userapi.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/users/profile';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  updateProfile(String name, String email, String password, String token,
      String filepath) async {
    final payload = {'name': name, 'email': email, 'password': password};
    final response = await http.put(
        Uri.parse('https://api-bali-journey.herokuapp.com/users/profile'),
        headers: {'access_token': token},
        body: payload);
    if (response.statusCode == 201) {
      if (_passwordController.text == '' ||
          _emailController.text == '' ||
          _nameController.text == '') {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          animationType: DialogTransitionType.slideFromBottomFade,
          curve: Curves.ease,
          builder: (context) {
            return AlertDialog(
              title: const Text('Update Failed'),
              content: const Text('Data Should not be Empty'),
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
        final uri = Uri.parse('http://10.0.2.2:3000/users/profile/img');
        var stream = http.ByteStream(imageFile!.openRead());
        stream.cast();
        var length = await imageFile!.length();
        var request = http.MultipartRequest('PUT', uri);
        request.headers['access_token'] = token;
        request.files.add(await http.MultipartFile.fromPath(
            'img', imageFile!.path,
            contentType: MediaType('image', p.extension(imageFile!.path))));
        var response = await request.send();
        if (response.statusCode == 201) {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            animationType: DialogTransitionType.slideFromBottomFade,
            curve: Curves.ease,
            builder: (context) {
              return AlertDialog(
                title: const Text('Update Successful'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(
                                builder: (builder) => HomePage()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text('OK'))
                ],
              );
            },
          );
          print('success');
        } else {
          print(response.statusCode);
        }
      }
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.ease,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Failed'),
            content: const Text('Update Failed'),
            actions: [
              TextButton(
                  onPressed: () {
                    _emailController.text = '';
                    _passwordController.text = '';
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
  void dispose() {
    _nameController.dispose();
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

  File? imageFile;
  String? imageFileName;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    imageFileName = pickedFile.name;
    setState(() {});
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
                                  'Edit Account',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          imageFile == null
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 30, 0),
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://api-bali-journey.herokuapp.com/$image',
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: Image.file(
                                      File(imageFile!.path).absolute,
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              height: 58,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 3,
                                      color: isDarkTheme
                                          ? Colors.white
                                          : const Color(0xff136068))),
                              child: Center(
                                child: Text(
                                  'Change Picture',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkTheme
                                          ? Colors.white
                                          : const Color(0xff136068)),
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
                            Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _nameController,
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068)),
                              decoration: InputDecoration(
                                fillColor: const Color(0xffD9F9F8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: isDarkTheme
                                            ? Colors.white
                                            : const Color(0xff136068))),
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
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _emailController,
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068)),
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
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _passwordController,
                              style: TextStyle(
                                  color: isDarkTheme
                                      ? Colors.white
                                      : const Color(0xff136068)),
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
                          onTap: () async {
                            var name = _nameController.text;
                            var email = _emailController.text;
                            var password = _passwordController.text;
                            final prefs = await SharedPreferences.getInstance();
                            String token = prefs.getString('jwt') ?? '';
                            updateProfile(
                                name, email, password, token, imageFile!.path);
                            // updateImage(token, imageFile!);
                          },
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
