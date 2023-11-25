// // ignore_for_file: non_constant_identifier_names

// import 'package:ugd_api_1/entity/Product.dart';

// import 'dart:convert';
// import 'package:http/http.dart';

// class ProductClient {
//   //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

//   // untuk emulator
//   static String url = '10.0.2.2:8000'; //base url
//   static String endpoint = '/api/product'; // base endpoint

//   // untuk hp
//   // static final String url = '192.168.0.105';
//   // static final String endpoint = '/GD_API_1097/public/api/Product';

//   // mengambil semua data Product dari API
//   static Future<List<Product>> fetchAll() async {
//     try {
//       var response = await get(
//           Uri.http(url, endpoint)); // request ke api dan menyimpan responsenya

//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);

//       // mengambil bagian data dari response body
//       Iterable list = json.decode(response.body)['data'];

//       // list.map untuk membuat list objek Product berdasarkan tiap elemen dari list
//       return list.map((e) => Product.fromJson(e)).toList();
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

//   // mengambil data Product dari API sesuai id
//   static Future<Product> find(id) async {
//     try {
//       var response = await get(Uri.http(url, '$endpoint/$id')); //request ke api

//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);

//       //membuat objek Product berdasarkan bagian data dari response body
//       return Product.fromJson(json.decode(response.body)['data']);
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

//   // membuat data Product baru
//   static Future<Response> create(Product product) async {
//     try {
//       var response = await post(Uri.http(url, endpoint),
//           headers: {"Content-Type": "application/json"},
//           body: product.toRawJson());
//       print(response.body);
//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);

//       return response;
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

//   // mengubah data Product sesuai id
//   static Future<Response> update(Product product) async {
//     try {
//       var response = await put(Uri.http(url, '$endpoint/${product.id}'),
//           headers: {"Content-Type": "application/json"},
//           body: product.toRawJson());

//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);

//       return response;
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

//   // mneghapus data Product sesuai ID
//   static Future<Response> destroy(id) async {
//     try {
//       var response = await delete(Uri.http(url, '$endpoint/$id'));

//       if (response.statusCode != 200) throw Exception(response.reasonPhrase);

//       return response;
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }
// }