// To parse this JSON data, do
//
//     final detailDestinationUserModel = detailDestinationUserModelFromJson(jsonString);

import 'dart:convert';

DetailDestinationUserModel detailDestinationUserModelFromJson(String str) =>
    DetailDestinationUserModel.fromJson(json.decode(str));

String detailDestinationUserModelToJson(DetailDestinationUserModel data) =>
    json.encode(data.toJson());

class DetailDestinationUserModel {
  DetailDestinationUserModel({
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
    required this.isWishlist,
    this.idWishlist,
    required this.images,
    required this.reviews,
    required this.userReview,
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
  DateTime createdAt;
  DateTime updatedAt;
  Category category;
  bool isWishlist;
  dynamic idWishlist;
  List<DataImage> images;
  List<dynamic> reviews;
  UserReview userReview;

  factory DetailDestinationUserModel.fromJson(Map<String, dynamic> json) =>
      DetailDestinationUserModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        rating: double.parse(json["rating"].toString()),
        description: json["description"],
        address: json["address"],
        openDay: json["open_day"],
        openTime: json["open_time"],
        mapLink: json["map_link"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Category.fromJson(json["category"]),
        isWishlist: json["is_wishlist"],
        idWishlist: json["id_wishlist"],
        images: List<DataImage>.from(
            json["images"].map((x) => DataImage.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        userReview: UserReview.fromJson(json["userReview"]),
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
        "is_wishlist": isWishlist,
        "id_wishlist": idWishlist,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "userReview": userReview.toJson(),
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

class UserReview {
  UserReview();

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview();

  Map<String, dynamic> toJson() => {};
}
