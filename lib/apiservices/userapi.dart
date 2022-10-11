import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_bali/models/detail_packagetrip_user_model.dart';
import 'package:wisata_bali/models/profile_model.dart';

import '../models/detail_destinations_user_model.dart';

class UserApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/users';
  Future<UserModel> getProfileData(String token) async {
    final response = await http
        .get(Uri.parse('$apiUrl/profile'), headers: {'access_token': token});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<DetailDestinationUserModel> getDestination(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');
    final response = await http.get(Uri.parse('$apiUrl/detail/dest/$id'),
        headers: {'access_token': jwt.toString()});
    if (response.statusCode == 200) {
      if (jwt != null) {
        return DetailDestinationUserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Jwt not found');
      }
    } else {
      throw Exception('Failed to Load');
    }
  }

  Future<DetailPackageTripUserModel> getPackageTrip(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');
    final response = await http.get(Uri.parse('$apiUrl/detail/pack/$id'),
        headers: {'access_token': jwt.toString()});
    if (response.statusCode == 200) {
      if (jwt != null) {
        return DetailPackageTripUserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('JWT not found');
      }
    } else {
      throw Exception('Failed to load');
    }
  }
}
