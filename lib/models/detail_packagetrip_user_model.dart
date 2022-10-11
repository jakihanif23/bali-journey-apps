// To parse this JSON data, do
//
//     final detailPackageTripUserModel = detailPackageTripUserModelFromJson(jsonString);

import 'dart:convert';

DetailPackageTripUserModel detailPackageTripUserModelFromJson(String str) =>
    DetailPackageTripUserModel.fromJson(json.decode(str));

String detailPackageTripUserModelToJson(DetailPackageTripUserModel data) =>
    json.encode(data.toJson());

class DetailPackageTripUserModel {
  DetailPackageTripUserModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.isWishlist,
    this.idWishlist,
    required this.images,
    required this.destinations,
    required this.reviews,
    required this.userReview,
  });

  int id;
  String name;
  String description;
  String price;
  int rating;
  bool isWishlist;
  dynamic idWishlist;
  List<DetailPackageTripUserModelImage> images;
  List<Destination> destinations;
  List<dynamic> reviews;
  UserReview userReview;

  factory DetailPackageTripUserModel.fromJson(Map<String, dynamic> json) =>
      DetailPackageTripUserModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"],
        isWishlist: json["is_wishlist"],
        idWishlist: json["id_wishlist"],
        images: List<DetailPackageTripUserModelImage>.from(json["images"]
            .map((x) => DetailPackageTripUserModelImage.fromJson(x))),
        destinations: List<Destination>.from(
            json["destinations"].map((x) => Destination.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        userReview: UserReview.fromJson(json["userReview"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "rating": rating,
        "is_wishlist": isWishlist,
        "id_wishlist": idWishlist,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "destinations": List<dynamic>.from(destinations.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "userReview": userReview.toJson(),
      };
}

class Destination {
  Destination({
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
    required this.category,
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
  Category category;
  List<DestinationImage> images;

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
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
        category: Category.fromJson(json["category"]),
        images: List<DestinationImage>.from(
            json["images"].map((x) => DestinationImage.fromJson(x))),
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

class DestinationImage {
  DestinationImage({
    required this.id,
    required this.destinationId,
    required this.img,
  });

  int id;
  int destinationId;
  String img;

  factory DestinationImage.fromJson(Map<String, dynamic> json) =>
      DestinationImage(
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

class DetailPackageTripUserModelImage {
  DetailPackageTripUserModelImage({
    required this.id,
    required this.packageTripId,
    required this.img,
  });

  int id;
  int packageTripId;
  String img;

  factory DetailPackageTripUserModelImage.fromJson(Map<String, dynamic> json) =>
      DetailPackageTripUserModelImage(
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

class UserReview {
  UserReview();

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview();

  Map<String, dynamic> toJson() => {};
}
