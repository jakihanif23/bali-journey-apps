import 'package:http/http.dart' as http;
import 'package:wisata_bali/models/wishlist_destination_model.dart';
import 'package:wisata_bali/models/wishlist_packagetrip_model.dart';

class WishlistApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/users/wishlist';
  Future<List<WishlistDestination>> getListDestinations(String token) async {
    var client = http.Client();
    var uri = Uri.parse('$apiUrl/dest');
    var response = await http.get(uri, headers: {'access_token': token});
    if (response.statusCode == 200) {
      var json = response.body;
      return wishlistDestinationFromJson(json);
    } else {
      throw Exception();
    }
  }

  Future<List<WishlistPackageTrip>> getListPackageTrip(String token) async {
    var client = http.Client();
    var uri = Uri.parse('$apiUrl/pack');
    var response = await http.get(uri, headers: {'access_token': token});
    if (response.statusCode == 200) {
      var json = response.body;
      return wishlistPackageTripFromJson(json);
    } else {
      throw Exception();
    }
  }
}
