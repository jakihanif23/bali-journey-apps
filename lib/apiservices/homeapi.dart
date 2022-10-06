import 'dart:convert';

import 'package:wisata_bali/models/destination_model.dart';
import 'package:wisata_bali/models/homemodel.dart';
import 'package:http/http.dart' as http;
import 'package:wisata_bali/models/packagetripmodel.dart';

class HomeApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/home';
  Future<HomeModel> getHomeApi() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return HomeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<PackageTripModel> getDataPackageTrip(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/packageTrip/$id'));
    if (response.statusCode == 200) {
      return PackageTripModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<DestinationModel> getDataDestination(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/destination/$id'));
    if (response.statusCode == 200) {
      return DestinationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Load');
    }
  }
}
