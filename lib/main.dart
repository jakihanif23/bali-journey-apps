import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_bali/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Bali App Journey',
        theme: ThemeData(textTheme: GoogleFonts.latoTextTheme(textTheme)),
        darkTheme: ThemeData.dark(),
        home: HomePage());
  }
}
