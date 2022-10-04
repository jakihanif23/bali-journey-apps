// To parse this JSON data, do
//
//     final wishlistPackageTrip = wishlistPackageTripFromJson(jsonString);

import 'dart:convert';

List<WishlistPackageTrip> wishlistPackageTripFromJson(String str) =>
    List<WishlistPackageTrip>.from(
        json.decode(str).map((x) => WishlistPackageTrip.fromJson(x)));

String wishlistPackageTripToJson(List<WishlistPackageTrip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistPackageTrip {
  WishlistPackageTrip({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  int id;
  String name;
  String description;
  String price;
  double rating;
  DateTime createdAt;
  DateTime updatedAt;
  List<ImageData> images;

  factory WishlistPackageTrip.fromJson(Map<String, dynamic> json) =>
      WishlistPackageTrip(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ImageData>.from(
            json["images"].map((x) => ImageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "rating": rating,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.packageTripId,
    required this.img,
  });

  int id;
  int packageTripId;
  String img;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        packageTripId: json["package_tripId"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_tripId": packageTripId,
        "img": img,
      };
}
