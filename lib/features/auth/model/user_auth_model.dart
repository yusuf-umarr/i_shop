// To parse this JSON data, do
//
//     final userAuthModel = userAuthModelFromJson(jsonString);

import 'dart:convert';

UserAuthModel userAuthModelFromJson(String str) => UserAuthModel.fromJson(json.decode(str));

String userAuthModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
    UserAuthModel({
        required this.token,
        required this.id,
        required this.name,
        required this.email,
        required this.password,
        required this.address,
        required this.type,
        required this.cart,
        required this.v,
    });

    String token;
    String id;
    String name;
    String email;
    String password;
    String address;
    String type;
    List<dynamic> cart;
    int v;

    factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        token: json["token"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        type: json["type"],
        cart: List<dynamic>.from(json["cart"].map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "cart": List<dynamic>.from(cart.map((x) => x)),
        "__v": v,
    };
}
