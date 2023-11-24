// ignore_for_file: non_constant_identifier_names

import 'package:ugd_api_1/entity/User.dart';

import 'dart:convert';
import 'package:http/http.dart';

class UserClient {
  //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

  // untuk emulator
  static String url = '10.0.2.2:8000'; //base url
  static String endpoint = '/api/user'; // base endpoint

  // untuk hp
  // static final String url = '192.168.0.105';
  // static final String endpoint = '/GD_API_1097/public/api/User';

  // mengambil semua data User dari API
  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint)); // request ke api dan menyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      // list.map untuk membuat list objek User berdasarkan tiap elemen dari list
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengambil data User dari API sesuai id
  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek User berdasarkan bagian data dari response body
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // membuat data User baru
  static Future<Response> create(User user) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengubah data User sesuai id
  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mneghapus data User sesuai ID
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
