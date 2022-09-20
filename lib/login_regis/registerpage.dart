import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/login_regis/backgound.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AuthBackground(),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 120),
                      child: Column(
                        children: [
                          Text(
                            'Welcome To',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle: TextStyle(color: Color(0xff136068))),
                          ),
                          Text(
                            'Bali Journey Apps',
                            style: GoogleFonts.salsa(
                                fontSize: 36,
                                textStyle: TextStyle(color: Color(0xff136068))),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 140),
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
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Username',
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
                                  'Register',
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
                                    text: 'Already Have an Account? ',
                                    style: TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: 'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).pop();
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
