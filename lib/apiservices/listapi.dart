import 'dart:convert';

import 'package:wisata_bali/models/list_destination_model.dart';
import 'package:wisata_bali/models/list_package_trip_model.dart';
import 'package:http/http.dart' as http;

class ListApi {
  final String apiUrl = 'http://10.0.2.2:3000/home';
  Future<List<ListPackageTripModel>?> listAllPackageTrip() async {
    var client = http.Client();
    var uri = Uri.parse('$apiUrl/allPackageTrip');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return listPackageTripModelFromJson(json);
    }
    return null;
  }

  Future<List<ListDestinationModel>?> listAllDestinations() async {
    var client = http.Client();
    var uri = Uri.parse('$apiUrl/allDestinations');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return listDestinationModelFromJson(json);
    }
    return null;
  }
}

class SearchDestination {
  var data = [];
  List<ListDestinationModel> results = [];
  String apiUrl = 'http://10.0.2.2:3000/home/allDestinations';
  Future<List<ListDestinationModel>> getDestinationsList() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        results = data.map((e) => ListDestinationModel.fromJson(e)).toList();
      } else {
        print('api error');
      }
    } on Exception catch (e) {
      print('Error : $e');
    }
    return results;
  }
}
