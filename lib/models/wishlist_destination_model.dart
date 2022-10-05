// To parse this JSON data, do
//
//     final wishlistPackageTrip = wishlistPackageTripFromJson(jsonString);

import 'dart:convert';

List<WishlistDestination> wishlistDestinationFromJson(String str) =>
    List<WishlistDestination>.from(
        json.decode(str).map((x) => WishlistDestination.fromJson(x)));

String wishlistDestinationToJson(List<WishlistDestination> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistDestination {
  WishlistDestination({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.description,
    required this.address,
    required this.openDay,
    required this.openTime,
    required this.mapLink,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  int id;
  String name;
  int categoryId;
  int rating;
  String description;
  String address;
  String openDay;
  String openTime;
  String mapLink;
  DateTime createdAt;
  DateTime updatedAt;
  List<ImageData> images;

  factory WishlistDestination.fromJson(Map<String, dynamic> json) =>
      WishlistDestination(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        rating: json["rating"],
        description: json["description"],
        address: json["address"],
        openDay: json["open_day"],
        openTime: json["open_time"],
        mapLink: json["map_link"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ImageData>.from(
            json["images"].map((x) => ImageData.fromJson(x))),
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.destinationId,
    required this.img,
  });

  int id;
  int destinationId;
  String img;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
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
