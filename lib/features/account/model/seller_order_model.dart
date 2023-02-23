// To parse this JSON data, do
//
//     final sellerOrder = sellerOrderFromJson(jsonString);

import 'dart:convert';

List<SellerOrder> sellerOrderFromJson(String str) => List<SellerOrder>.from(json.decode(str).map((x) => SellerOrder.fromJson(x)));

String sellerOrderToJson(List<SellerOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellerOrder {
    SellerOrder({
        this.product,
        this.quantity,
        this.id,
    });

    Product? product;
    int? quantity;
    String? id;

    factory SellerOrder.fromJson(Map<String, dynamic> json) => SellerOrder(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"] == null ? null : json["quantity"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "quantity": quantity == null ? null : quantity,
        "_id": id == null ? null : id,
    };
}

class Product {
    Product({
        this.name,
        this.description,
        this.images,
        this.quantity,
        this.price,
        this.category,
        this.sellerId,
        this.ratings,
        this.id,
        this.v,
    });

    String? name;
    String? description;
    List<String>? images;
    int? quantity;
    int? price;
    String? category;
    String? sellerId;
    List<dynamic>? ratings;
    String? id;
    int? v;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        category: json["category"] == null ? null : json["category"],
        sellerId: json["sellerId"] == null ? null : json["sellerId"],
        ratings: json["ratings"] == null ? null : List<dynamic>.from(json["ratings"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "category": category == null ? null : category,
        "sellerId": sellerId == null ? null : sellerId,
        "ratings": ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x)),
        "_id": id == null ? null : id,
        "__v": v == null ? null : v,
    };
}
