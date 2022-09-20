import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/login_regis/backgound.dart';
import 'package:wisata_bali/login_regis/registerpage.dart';
import 'package:wisata_bali/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AuthBackground(),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 120),
                      child: Column(
                        children: [
                          Text(
                            'Welcome To',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    TextStyle(color: Color(0xff136068))),
                          ),
                          Text(
                            'Bali Journey Apps',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle:
                                    TextStyle(color: Color(0xff136068))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Color(0xff136068).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset('assets/google_logos.png'),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: EdgeInsets.fromLTRB(65, 0, 65, 0),
                              decoration: BoxDecoration(
                                  color: Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Email',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 45,
                              margin: EdgeInsets.fromLTRB(65, 15, 65, 0),
                              decoration: BoxDecoration(
                                  color: Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: TextField(
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Password',
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 166,
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                              decoration: BoxDecoration(
                                  color: Color(0xff136068).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t an have Account? ',
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: 'Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context)=>RegisterPage())
                                              );
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
