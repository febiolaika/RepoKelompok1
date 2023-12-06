import 'dart:convert';

class ProductModel {
  final int status;
  final String message;
  final Product data;

  const ProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        data: Product.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Product {
  int id;
  String nama;
  double harga;
  int durasi;
  dynamic data;

  Product(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.durasi,
      required this.data});

  //untuk membuat objek barang dari data json yang diterima dari API
  factory Product.fromRawJson(String str) =>
      Product.fromRawJson(json.decode(str));
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"].toDouble(),
        durasi: int.parse(json["durasi"]),
        data: json["data"],
      );

  //untuk membuat data json dari objek barang yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "durasi": durasi,
        "data": data,
      };
}
