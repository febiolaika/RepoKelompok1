// ignore_for_file: file_names

import 'dart:convert';

class Product {
  int id;
  String nama;
  double harga;
  String durasi;
  //final Map<String, dynamic>? data;

  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.durasi,
    //required this.data,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      nama: json["nama"],
      harga: json["harga"].toDouble(),
      durasi: json["durasi"], 
      //data: json["data"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "durasi": durasi,
        //"data": data,
      };
}
