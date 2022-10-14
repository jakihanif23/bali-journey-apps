// To parse this JSON data, do
//
//     final packageTripModel = packageTripModelFromJson(jsonString);

import 'dart:convert';

PackageTripModel packageTripModelFromJson(String str) =>
    PackageTripModel.fromJson(json.decode(str));

String packageTripModelToJson(PackageTripModel data) =>
    json.encode(data.toJson());

class PackageTripModel {
  PackageTripModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.destinations,
    required this.reviews,
  });

  int id;
  String name;
  String description;
  String price;
  dynamic rating;
  List<ImageData> images;
  List<dynamic> destinations;
  List<dynamic> reviews;

  factory PackageTripModel.fromJson(Map<String, dynamic> json) =>
      PackageTripModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"],
        images: List<ImageData>.from(
            json["images"].map((x) => ImageData.fromJson(x))),
        destinations: List<dynamic>.from(json["destinations"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "destinations": List<dynamic>.from(destinations.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
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
