import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/login_regis/loginpage.dart';
import 'package:wisata_bali/widgets/login_button.dart';

import '../icons/custom_icons_icons.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text(
                'Account',
                style: GoogleFonts.salsa(
                    fontSize: 36,
                    textStyle: TextStyle(color: Color(0xff136068))
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      'Login to give reviews and booking your trip',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff136068)
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(builder: (context)=>LoginPage())
                        );
                      },
                      child: LoginButton('Login'),
                    )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: Text(
                'Support',
                style: GoogleFonts.salsa(
                    fontSize: 36,
                    textStyle: TextStyle(color: Color(0xff136068))
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){},
              child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'About Bali Journey App',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff136068)
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: SvgPicture.asset('assets/arrow_top_right.svg', color: Color(0xff136068),),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
