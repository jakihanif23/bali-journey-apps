import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/login_regis/loginpage.dart';
import 'package:wisata_bali/pages/about_app_page.dart';
import 'package:wisata_bali/widgets/login_button.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text(
                'Account',
                style: GoogleFonts.salsa(
                    fontSize: 36,
                    textStyle: TextStyle(
                        color: isDarkTheme
                            ? Colors.white
                            : const Color(0xff136068))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: isDarkTheme ? Colors.white : Colors.black),
                      bottom: BorderSide(
                          color: isDarkTheme ? Colors.white : Colors.black))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      'Login to give reviews and booking your trip',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkTheme
                              ? Colors.white
                              : const Color(0xff136068)),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: LoginButton('Login'),
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Text(
                'Support',
                style: GoogleFonts.salsa(
                    fontSize: 36,
                    textStyle: TextStyle(
                        color: isDarkTheme
                            ? Colors.white
                            : const Color(0xff136068))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute(builder: (_) => const AboutAppPage()));
              },
              child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: isDarkTheme ? Colors.white : Colors.black),
                          bottom: BorderSide(
                              color:
                                  isDarkTheme ? Colors.white : Colors.black))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          'About Bali Journey App',
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xff136068)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: SvgPicture.asset(
                          'assets/arrow_top_right.svg',
                          color: isDarkTheme
                              ? Colors.white
                              : const Color(0xff136068),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
