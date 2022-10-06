import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class dataaja extends StatefulWidget {
  const dataaja({Key? key}) : super(key: key);

  @override
  State<dataaja> createState() => _dataajaState();
}

class _dataajaState extends State<dataaja> {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/home/category';
  var myData;

  @override
  void initState() {
    _fetchDataUsers();
    super.initState();
  }

  Future<dynamic> _fetchDataUsers() async {
    try {
      var result = await http.get(Uri.parse(apiUrl));
      var res = jsonDecode(result.body);
      print('ini dari func fetch : $res');
      if (result.statusCode == 200) {
        setState(() {
          myData = res;
        });
      }
      print('ini list length : ${result.body}');
      return res;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
