import 'dart:convert';

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
