// To parse this JSON data, do
//
//     final dataPaymentChecking = dataPaymentCheckingFromJson(jsonString);

import 'dart:convert';

DataPaymentChecking dataPaymentCheckingFromJson(String str) =>
    DataPaymentChecking.fromJson(json.decode(str));

String dataPaymentCheckingToJson(DataPaymentChecking data) =>
    json.encode(data.toJson());

class DataPaymentChecking {
  DataPaymentChecking({
    required this.id,
    required this.userId,
    required this.paymentCode,
    required this.total,
    required this.paymentType,
    required this.bank,
    required this.vaNumber,
    required this.status,
  });

  int id;
  int userId;
  String paymentCode;
  String total;
  String paymentType;
  String bank;
  String vaNumber;
  String status;

  factory DataPaymentChecking.fromJson(Map<String, dynamic> json) =>
      DataPaymentChecking(
        id: json["id"],
        userId: json["userId"],
        paymentCode: json["payment_code"],
        total: json["total"],
        paymentType: json["payment_type"],
        bank: json["bank"],
        vaNumber: json["va_number"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "payment_code": paymentCode,
        "total": total,
        "payment_type": paymentType,
        "bank": bank,
        "va_number": vaNumber,
        "status": status,
      };
}
