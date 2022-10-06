import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/models/cart_model.dart';

class CartApi {
  final String url =
      'https://api-bali-journey.herokuapp.com/users/payments/carts';
  Future<CartModel> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    var getString = prefs.getString('jwt');
    var response = await http
        .get(Uri.parse(url), headers: {'access_token': getString.toString()});
    if (response.statusCode == 200) {
      return CartModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
