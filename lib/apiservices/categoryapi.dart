import 'package:http/http.dart' as http;
import 'package:wisata_bali/models/category.dart';

class CategoryApi {
  final String apiUrl = 'https://api-bali-journey.herokuapp.com/home/category';
  Future<List<CategoryModel>?> listCategories() async {
    var client = http.Client();
    var uri = Uri.parse(apiUrl);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return categoryFromJson(json);
    }
    return null;
  }
}
