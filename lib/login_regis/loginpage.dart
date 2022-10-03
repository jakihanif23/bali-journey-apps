import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/login_regis/backgound.dart';
import 'package:wisata_bali/login_regis/registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_bali/utils/constant.dart';

import '../mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  loginUser(String email, String password) async {
    const String apiUrl = 'http://10.0.2.2:3000/home';
    var loginArr;
    var response = await http.post(Uri.parse('$apiUrl/login'),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      loginArr = json.decode(response.body);
      setJwt(loginArr['accessToken']);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Successful'),
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
          });
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AuthBackground(),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 120),
                      child: Column(
                        children: [
                          Text(
                            'Welcome To',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    const TextStyle(color: Color(0xff136068))),
                          ),
                          Text(
                            'Bali Journey Apps',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    const TextStyle(color: Color(0xff136068))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 70),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: const Color(0xff136068).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset('assets/google_logos.png'),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: const EdgeInsets.fromLTRB(65, 0, 65, 0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Password',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                loginUser(_emailController.text,
                                    _passwordController.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 45,
                                width: 166,
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                decoration: BoxDecoration(
                                    color: const Color(0xff136068)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 40),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t an have Account? ',
                                    style: const TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: 'Register',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const RegisterPage()));
                                            })
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
