// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
    PaymentModel({
        required this.status,
        required this.message,
        required this.data,
    });

    bool status;
    String message;
    Data data;

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
         this.authorizationUrl,
         this.accessCode,
         this.reference,
    });

    String? authorizationUrl;
    String? accessCode;
    String? reference;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        authorizationUrl: json["authorization_url"],
        accessCode: json["access_code"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "authorization_url": authorizationUrl,
        "access_code": accessCode,
        "reference": reference,
    };
}
