// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

List<MyOrderModel> myOrderModelFromJson(String str) => List<MyOrderModel>.from(json.decode(str).map((x) => MyOrderModel.fromJson(x)));

String myOrderModelToJson(List<MyOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyOrderModel {
    MyOrderModel({
        required this.id,
        required this.cartProducts,
        required this.address,
        required this.userId,
        required this.orderedAt,
        required this.status,
        required this.v,
    });

    String id;
    List<CartProduct> cartProducts;
    String address;
    String userId;
    int orderedAt;
    int status;
    int v;

    factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        id: json["_id"],
        cartProducts: List<CartProduct>.from(json["cartProducts"].map((x) => CartProduct.fromJson(x))),
        address: json["address"],
        userId: json["userId"],
        orderedAt: json["orderedAt"],
        status: json["status"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cartProducts": List<dynamic>.from(cartProducts.map((x) => x.toJson())),
        "address": address,
        "userId": userId,
        "orderedAt": orderedAt,
        "status": status,
        "__v": v,
    };
}

class CartProduct {
    CartProduct({
        required this.id,
        required this.name,
        required this.description,
        required this.images,
        required this.quantity,
        required this.price,
        required this.category,
        required this.ratings,
        required this.v,
    });

    String id;
    String name;
    String description;
    List<String> images;
    int quantity;
    int price;
    String category;
    List<dynamic> ratings;
    int v;

    factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"],
        price: json["price"],
        category: json["category"],
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "price": price,
        "category": category,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "__v": v,
    };
}
