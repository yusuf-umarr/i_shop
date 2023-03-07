// // To parse this JSON data, do
// //
// //     final orderedModel = orderedModelFromJson(jsonString);

// import 'dart:convert';

// List<OrderedModel> orderedModelFromJson(String str) => List<OrderedModel>.from(json.decode(str).map((x) => OrderedModel.fromJson(x)));

// String orderedModelToJson(List<OrderedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OrderedModel {
//     OrderedModel({
//         required this.id,
//         required this.products,
//         required this.totalPrice,
//         required this.address,
//         required this.userId,
//         required this.orderedAt,
//         required this.status,
//         required this.v,
//     });

//     String id;
//     List<ProductElement> products;
//     int totalPrice;
//     String address;
//     String userId;
//     int orderedAt;
//     int status;
//     int v;

//     factory OrderedModel.fromJson(Map<String, dynamic> json) => OrderedModel(
//         id: json["_id"],
//         products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
//         totalPrice: json["totalPrice"],
//         address: json["address"],
//         userId: json["userId"],
//         orderedAt: json["orderedAt"],
//         status: json["status"],
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "products": List<dynamic>.from(products.map((x) => x.toJson())),
//         "totalPrice": totalPrice,
//         "address": address,
//         "userId": userId,
//         "orderedAt": orderedAt,
//         "status": status,
//         "__v": v,
//     };
// }

// class ProductElement {
//     ProductElement({
//         required this.product,
//         required this.quantity,
//         required this.id,
//     });

//     ProductProduct product;
//     int quantity;
//     String id;

//     factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
//         product: ProductProduct.fromJson(json["product"]),
//         quantity: json["quantity"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "product": product.toJson(),
//         "quantity": quantity,
//         "_id": id,
//     };
// }

// class ProductProduct {
//     ProductProduct({
//         required this.name,
//         required this.description,
//         required this.images,
//         required this.quantity,
//         required this.price,
//         required this.category,
//         required this.ratings,
//         required this.id,
//         required this.v,
//     });

//     String name;
//     String description;
//     List<String> images;
//     int quantity;
//     int price;
//     String category;
//     List<Rating> ratings;
//     String id;
//     int v;

//     factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
//         name: json["name"],
//         description: json["description"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         quantity: json["quantity"],
//         price: json["price"],
//         category: json["category"],
//         ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
//         id: json["_id"],
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "quantity": quantity,
//         "price": price,
//         "category": category,
//         "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
//         "_id": id,
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
