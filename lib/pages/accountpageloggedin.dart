import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/widgets/login_button.dart';

class AccountPageLoggedIn extends StatefulWidget {
  const AccountPageLoggedIn({Key? key}) : super(key: key);

  @override
  State<AccountPageLoggedIn> createState() => _AccountPageLoggedInState();
}

class _AccountPageLoggedInState extends State<AccountPageLoggedIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                      textStyle: const TextStyle(color: Color(0xff136068))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'My Account',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff136068)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: SvgPicture.asset(
                            'assets/arrow_top_right.svg',
                            color: const Color(0xff136068),
                          ),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'Transaction History',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff136068)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: SvgPicture.asset(
                            'assets/arrow_top_right.svg',
                            color: const Color(0xff136068),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 0, 0),
                child: Text(
                  'Support',
                  style: GoogleFonts.salsa(
                      fontSize: 36,
                      textStyle: const TextStyle(color: Color(0xff136068))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            'About Bali Journey App',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff136068)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: SvgPicture.asset(
                            'assets/arrow_top_right.svg',
                            color: const Color(0xff136068),
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: LoginButton('Logout'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
