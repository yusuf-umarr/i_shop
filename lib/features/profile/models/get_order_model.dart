// // To parse this JSON data, do
// //
// //     final getOrderModel = getOrderModelFromJson(jsonString);

// import 'dart:convert';

// List<GetOrderModel> getOrderModelFromJson(String str) => List<GetOrderModel>.from(json.decode(str).map((x) => GetOrderModel.fromJson(x)));

// String getOrderModelToJson(List<GetOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class GetOrderModel {
//     GetOrderModel({
//         required this.id,
//         required this.cartProducts,
//         required this.address,
//         required this.userId,
//         required this.orderedAt,
//         required this.status,
//         required this.v,
//     });

//     String id;
//     List<CartProduct> cartProducts;
//     String address;
//     String userId;
//     int orderedAt;
//     int status;
//     int v;

//     factory GetOrderModel.fromJson(Map<String, dynamic> json) => GetOrderModel(
//         id: json["_id"],
//         cartProducts: List<CartProduct>.from(json["cartProducts"].map((x) => CartProduct.fromJson(x))),
//         address: json["address"],
//         userId: json["userId"],
//         orderedAt: json["orderedAt"],
//         status: json["status"],
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "cartProducts": List<dynamic>.from(cartProducts.map((x) => x.toJson())),
//         "address": address,
//         "userId": userId,
//         "orderedAt": orderedAt,
//         "status": status,
//         "__v": v,
//     };
// }

// class CartProduct {
//     CartProduct({
//         required this.product,
//         required this.quantity,
//         required this.id,
//     });

//     Product product;
//     int quantity;
//     String id;

//     factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
//         product: Product.fromJson(json["product"]),
//         quantity: json["quantity"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "product": product.toJson(),
//         "quantity": quantity,
//         "_id": id,
//     };
// }

// class Product {
//     Product({
//         required this.id,
//         required this.name,
//         required this.description,
//         required this.images,
//         required this.quantity,
//         required this.price,
//         required this.category,
//         required this.ratings,
//         required this.v,
//     });

//     String id;
//     String name;
//     String description;
//     List<String> images;
//     int quantity;
//     int price;
//     String category;
//     List<Rating> ratings;
//     int v;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["_id"],
//         name: json["name"],
//         description: json["description"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         quantity: json["quantity"],
//         price: json["price"],
//         category: json["category"],
//         ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "quantity": quantity,
//         "price": price,
//         "category": category,
//         "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
//         "__v": v,
//     };
// }

// class Rating {
//     Rating({
//         required this.userId,
//         required this.rating,
//         required this.id,
//     });

//     String userId;
//     int rating;
//     String id;

//     factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         userId: json["userId"],
//         rating: json["rating"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "rating": rating,
//         "_id": id,
//     };
// }
