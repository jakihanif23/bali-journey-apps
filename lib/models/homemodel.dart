// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    required this.recDest,
    required this.recPackage,
  });

  List<RecDest> recDest;
  List<RecPackage> recPackage;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        recDest:
            List<RecDest>.from(json["recDest"].map((x) => RecDest.fromJson(x))),
        recPackage: List<RecPackage>.from(
            json["recPackage"].map((x) => RecPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recDest": List<dynamic>.from(recDest.map((x) => x.toJson())),
        "recPackage": List<dynamic>.from(recPackage.map((x) => x.toJson())),
      };
}

class RecDest {
  RecDest({
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
  List<RecDestImage> images;

  factory RecDest.fromJson(Map<String, dynamic> json) => RecDest(
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
        images: List<RecDestImage>.from(
            json["images"].map((x) => RecDestImage.fromJson(x))),
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

class RecDestImage {
  RecDestImage({
    required this.id,
    required this.destinationId,
    required this.img,
  });

  int id;
  int destinationId;
  String img;

  factory RecDestImage.fromJson(Map<String, dynamic> json) => RecDestImage(
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

class RecPackage {
  RecPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.destinations,
  });

  int id;
  String name;
  String description;
  String price;
  int rating;
  List<RecPackageImage> images;
  List<dynamic> destinations;

  factory RecPackage.fromJson(Map<String, dynamic> json) => RecPackage(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"],
        images: List<RecPackageImage>.from(
            json["images"].map((x) => RecPackageImage.fromJson(x))),
        destinations: List<dynamic>.from(json["destinations"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "destinations": List<dynamic>.from(destinations.map((x) => x)),
      };
}

class RecPackageImage {
  RecPackageImage({
    required this.id,
    required this.packageTripId,
    required this.img,
  });

  int id;
  int packageTripId;
  String img;

  factory RecPackageImage.fromJson(Map<String, dynamic> json) =>
      RecPackageImage(
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
