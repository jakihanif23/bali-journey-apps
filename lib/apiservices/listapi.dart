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

  Future<List<ListDestinationModel>?> listAllDestinationsbyCategory(
      int? id) async {
    var client = http.Client();
    var uri = Uri.parse('$apiUrl/dest-by-cat/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return listDestinationModelFromJson(json);
    }
    return null;
  }
}
