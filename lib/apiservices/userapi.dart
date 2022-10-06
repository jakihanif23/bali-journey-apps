import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wisata_bali/models/profile_model.dart';

class UserApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/users/profile';
  Future<UserModel> getProfileData(String token) async {
    final response =
        await http.get(Uri.parse(apiUrl), headers: {'access_token': token});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
