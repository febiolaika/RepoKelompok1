// ignore_for_file: file_names

import 'dart:convert';

class Product {
  int id;
  int idUser;
  String name;
  String price;
  String duration;
  String image;

  Product({
    required this.id,
    required this.idUser,
    required this.name,
    required this.price,
    required this.duration,
    required this.image,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      idUser: json["idUser"],
      name: json["name"],
      price: json["price"],
      duration: json["duration"],
      image: json["image"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "name": name,
        "price": price,
        "duration": duration,
        "image": image,
      };
}
