import 'package:ugd6_1217/entity/Product.dart';

import 'dart:convert';
import 'package:http/http.dart';

class ProductClient {
  //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

  // untuk emulator
  static final String url = '10.0.2.2:8000'; //base url
  static final String endpoint = '/api/product'; // base endpoint

  // untuk hp
  // static final String url = '192.168.0.105';
  // static final String endpoint = '/GD_API_1032/public/api/barang';

  // mengambil semua data barang dari API
  static Future<List<Product>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint)); // request ke api dan menyimpan responsenya

          if (response.statusCode != 200) throw Exception(response.reasonPhrase);

          // mengambil bagian data dari response body
          Iterable list = json.decode(response.body)['data'];

          // list.map untuk membuat list objek Barang berdasarkan tiap elemen dari list
          return list.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengambil data barang dari API sesuai id
  static Future<Product> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek barang berdasarkan bagian data dari response body
      return Product.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // membuat data barang baru
  static Future<Response> create(Product product) async {
    try {
      var response = await post(Uri.http(url, endpoint),
      headers: {"Content-Type": "application/json"},
      body: product.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengubah data barang sesuai id
  static Future<Response> update(Product product) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${product.id}'),
      headers: {"Content-Type": "application/json"},
      body: product.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mneghapus data barang sesuai ID
  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}