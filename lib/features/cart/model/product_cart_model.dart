//To parse this JSON data, do
//
//     final ProductCartModel = ProductCartModelFromJson(jsonString);

import 'dart:convert';

import 'package:i_shop_riverpod/features/product_category/models/product_model.dart';

List<ProductCartModel> productCartModelFromJson(String str) =>
    List<ProductCartModel>.from(
        json.decode(str).map((x) => ProductCartModel.fromJson(x)));

String productCartModelToJson(List<ProductCartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCartModel {
  ProductCartModel({
    this.product,
    this.quantity,
    this.id,
  });

  ProductModel? product;
  int? quantity;
  String? id;

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      ProductCartModel(
        product: json["product"] == null
            ? null
            : ProductModel.fromJson(json["product"]),
        quantity: json["quantity"] == null ? null : json["quantity"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "quantity": quantity == null ? null : quantity,
        "_id": id == null ? null : id,
      };
}
