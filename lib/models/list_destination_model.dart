// To parse this JSON data, do
//
//     final listDestinationModel = listDestinationModelFromJson(jsonString);

import 'dart:convert';

List<ListDestinationModel> listDestinationModelFromJson(String str) =>
    List<ListDestinationModel>.from(
        json.decode(str).map((x) => ListDestinationModel.fromJson(x)));

String listDestinationModelToJson(List<ListDestinationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListDestinationModel {
  ListDestinationModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.description,
    required this.address,
    required this.openDay,
    required this.openTime,
    required this.mapLink,
    required this.category,
    required this.images,
  });

  int id;
  String name;
  int categoryId;
  double rating;
  String description;
  String address;
  String openDay;
  String openTime;
  String mapLink;
  Category category;
  List<DataImage> images;

  factory ListDestinationModel.fromJson(Map<String, dynamic> json) =>
      ListDestinationModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        rating: json["rating"].toDouble(),
        description: json["description"],
        address: json["address"],
        openDay: json["open_day"],
        openTime: json["open_time"],
        mapLink: json["map_link"],
        category: Category.fromJson(json["category"]),
        images: List<DataImage>.from(
            json["images"].map((x) => DataImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "rating": rating,
        "description": description,
        "address": address,
        "open_day": openDay,
        "open_time": openTime,
        "map_link": mapLink,
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class DataImage {
  DataImage({
    required this.id,
    required this.destinationId,
    required this.img,
  });

  int id;
  int destinationId;
  String img;

  factory DataImage.fromJson(Map<String, dynamic> json) => DataImage(
        id: json["id"],
        destinationId: json["destinationId"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "destinationId": destinationId,
        "img": img,
      };
}
