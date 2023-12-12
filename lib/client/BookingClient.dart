import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ugd6_1217/entity/Booking.dart';

class BookingClient {
  //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

  // untuk emulator
  static String url = '10.0.2.2:8000'; //base url
  static String endpoint = '/api/Booking'; // base endpoint
  static http.Client client = http.Client();

  static Future<Booking?> login(
      {required String nama,
      required String nomorponsel,
      required DateTime tanggalbooking,
      required String jamdatang,
      required String jenislayanan,
      required http.Client client}) async {
    String apiURL = 'http://10.0.2.2:8000/api/Booking';
    try {
      var apiResult = await client.post(
        Uri.parse(apiURL),
        body: {'nama': nama, 'nomorponsel': nomorponsel, 'tanggalbooking': tanggalbooking, 'jamdatang': jamdatang, 'jenislayanan': jenislayanan},
      );
      if (apiResult.statusCode == 200) {
        return Booking.fromRawJson(apiResult.body);
      } else {
        throw Exception('Failed to Input Booking');
      }
    } catch (e) {
      return null;
    }
  }

  // untuk hp
  // static final String url = '192.168.0.105';
  // static final String endpoint = '/GD_API_1032/public/api/barang';

  // mengambil semua data barang dari API
  static Future<List<Booking>> fetchAll() async {
    try {
      var response = await http.get(
          Uri.http(url, endpoint)); // request ke api dan menyimpan responsenya

      if (response.statusCode != 200) {
        throw Exception('Failed to load Booking: ${response.reasonPhrase}');
      }
      
      // Parse the JSON data
      var jsonData = json.decode(response.body);
      if (jsonData == null || jsonData['data'] == null) {
        throw Exception('Invalid JSON format or missing data field');
      }

      // mengambil bagian data dari response body
      Iterable list = jsonData['data'];

      // list.map untuk membuat list objek Barang berdasarkan tiap elemen dari list
      return list.map((e) => Booking.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengambil data barang dari API sesuai id
  static Future<Booking> find(id) async {
    try {
      var response =
          await http.get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek barang berdasarkan bagian data dari response body
      return Booking.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // membuat data barang baru
  static Future<http.Response> create(Booking booking) async {
    try {
      var response = await http.post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: booking.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengubah data barang sesuai id
  static Future<http.Response> update(Booking booking) async {
    try {
      var response = await http.put(Uri.http(url, '$endpoint/${booking.id}'),
          headers: {"Content-Type": "application/json"},
          body: booking.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mneghapus data barang sesuai ID
  static Future<http.Response> destroy(id) async {
    try {
      var response = await http.delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // static Future<Product?> productTesting({
  //   required String nama,
  //   required double harga,
  //   required String durasi,
  // }) async {
  //   String apiURL = 'http://127.0.0.1:8000/api/inputProduct';
  //   try {
  //     var apiResult = await http.post(
  //       Uri.parse(apiURL),
  //       body: {'nama': nama, 'harga': harga, 'durasi': durasi},
  //     );
  //     if (apiResult.statusCode == 200) {
  //       final result = Product.fromRawJson(apiResult.body);
  //       return result;
  //     } else {
  //       throw Exception('Failed to login');
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
