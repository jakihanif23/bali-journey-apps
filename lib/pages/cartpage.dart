import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_bali/models/homemodel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/home';
  Future<HomeModel> listHome() async {
    var uri = Uri.parse(apiUrl);
    var response = await http.get(uri);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return HomeModel.fromJson(data);
    } else {
      return HomeModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: const Text('wwwwww'),
    ));
  }
}
