import 'dart:convert';

import 'package:http/http.dart' as http;
class CategoryModel {
  int id;
  String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.createUser(Map<String, dynamic> object){
    return CategoryModel(
      id: object['id'],
      name: object['name']
    );
  }
  static Future<CategoryModel> connectToApi(String id) async {
    String apiUrl = 'http://10.0.2.2:3000/home/category' + id;
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>);
    return CategoryModel.createUser(userData);
  }
}