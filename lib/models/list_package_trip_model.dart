// To parse this JSON data, do
//
//     final listPackageTripModel = listPackageTripModelFromJson(jsonString);

import 'dart:convert';

List<ListPackageTripModel> listPackageTripModelFromJson(String str) =>
    List<ListPackageTripModel>.from(
        json.decode(str).map((x) => ListPackageTripModel.fromJson(x)));

String listPackageTripModelToJson(List<ListPackageTripModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPackageTripModel {
  ListPackageTripModel({
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
  double rating;
  List<DataImage> images;
  List<DestinationElement> destinations;

  factory ListPackageTripModel.fromJson(Map<String, dynamic> json) =>
      ListPackageTripModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        rating: json["rating"].toDouble(),
        images: List<DataImage>.from(
            json["images"].map((x) => DataImage.fromJson(x))),
        destinations: List<DestinationElement>.from(
            json["destinations"].map((x) => DestinationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "destinations": List<dynamic>.from(destinations.map((x) => x.toJson())),
      };
}

class DestinationElement {
  DestinationElement({
    required this.id,
    required this.packageTripId,
    required this.destinationId,
    required this.createdAt,
    required this.updatedAt,
    required this.destination,
  });

  int id;
  int packageTripId;
  int destinationId;
  DateTime createdAt;
  DateTime updatedAt;
  DestinationDestination destination;

  factory DestinationElement.fromJson(Map<String, dynamic> json) =>
      DestinationElement(
        id: json["id"],
        packageTripId: json["package_tripId"],
        destinationId: json["destinationId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        destination: DestinationDestination.fromJson(json["destination"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_tripId": packageTripId,
        "destinationId": destinationId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "destination": destination.toJson(),
      };
}

class DestinationDestination {
  DestinationDestination({
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

  factory DestinationDestination.fromJson(Map<String, dynamic> json) =>
      DestinationDestination(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        rating: json["rating"].toDouble(),
        description: json["description"],
        address: json["address"],
        openDay: json["open_day"],
        openTime: json["open_time"],
        mapLink: json["map_link"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
      };
}

class DataImage {
  DataImage({
    required this.id,
    required this.packageTripId,
    required this.img,
  });

  int id;
  int packageTripId;
  String img;

  factory DataImage.fromJson(Map<String, dynamic> json) => DataImage(
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
