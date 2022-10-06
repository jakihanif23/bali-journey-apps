// To parse this JSON data, do
//
//     final listPaymentHistoryModel = listPaymentHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ListPaymentHistoryModel> listPaymentHistoryModelFromJson(String str) =>
    List<ListPaymentHistoryModel>.from(
        json.decode(str).map((x) => ListPaymentHistoryModel.fromJson(x)));

String listPaymentHistoryModelToJson(List<ListPaymentHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPaymentHistoryModel {
  ListPaymentHistoryModel({
    required this.id,
    required this.userId,
    required this.paymentCode,
    required this.total,
    required this.status,
    required this.responseMidtrans,
    required this.cartItems,
  });

  int id;
  int userId;
  String paymentCode;
  String total;
  String status;
  String responseMidtrans;
  List<CartItem> cartItems;

  factory ListPaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      ListPaymentHistoryModel(
        id: json["id"],
        userId: json["userId"],
        paymentCode: json["payment_code"],
        total: json["total"],
        status: json["status"],
        responseMidtrans: json["responseMidtrans"],
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "payment_code": paymentCode,
        "total": total,
        "status": status,
        "responseMidtrans": responseMidtrans,
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}

class CartItem {
  CartItem({
    required this.id,
    required this.paymentId,
    required this.date,
    required this.packageTripId,
    required this.amount,
    required this.name,
    required this.price,
    required this.rating,
    required this.images,
  });

  int id;
  int paymentId;
  DateTime date;
  int packageTripId;
  int amount;
  String name;
  String price;
  int rating;
  List<DataImage> images;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        paymentId: json["paymentId"],
        date: DateTime.parse(json["date"]),
        packageTripId: json["package_tripId"],
        amount: json["amount"],
        name: json["name"],
        price: json["price"],
        rating: json["rating"],
        images: List<DataImage>.from(
            json["images"].map((x) => DataImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentId": paymentId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "package_tripId": packageTripId,
        "amount": amount,
        "name": name,
        "price": price,
        "rating": rating,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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
