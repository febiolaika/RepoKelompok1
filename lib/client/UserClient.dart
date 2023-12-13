// ignore_for_file: non_constant_identifier_names

import 'package:ugd6_1217/entity/User.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserClient {
  //sesuaikan url dan endpoint dengan device yang kalian gunakan untuk uji coba sesuai langkah 7

  // untuk emulator
  static String url = '10.0.2.2:8000'; //base url
  static String endpoint = '/api/user'; // base endpoint
  static http.Client client = http.Client();

  static Future<LoginModel?> login(
      {required  String username,
      required String password,
      required http.Client client}) async {
    String apiURL = 'http://10.0.2.2:8000/api/login';
    try {
      var apiResult = await client.post(
        Uri.parse(apiURL),
        body: {'username': username, 'password': password},
      );
      print('API Response Status Code: ${apiResult.statusCode}');
      print('Raw API Response: ${apiResult.body}');
      if (apiResult.statusCode == 200) {
        LoginModel loginResult = LoginModel.fromRawJson(apiResult.body);

      // Save user data in SharedPreferences if login is successful
      if (loginResult.status == true && loginResult.data != null) {
        User user = User.fromJson(loginResult.data!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('userId', user.id);
        prefs.setString('username', user.username);
        prefs.setString('email', user.email);
        prefs.setString('noHp', user.noHp);
        prefs.setString('gender', user.gender);
        // Add more user data fields as needed
        print('berhasil');
      }
      print('gagal');
      return loginResult;
      } else {
        throw Exception('Failed to login. Status Code: ${apiResult.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  static Future<User?> getDataUserFromServer(int userId) async {
    try {
      var response = await http.get(
        Uri.http(url, '$endpoint/$userId'),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // static Future<User?> getDataUserFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('userId');

  //   if (userId != null) {
  //     try {
  //       return await getDataUserFromServer(userId);
  //     } catch (e) {
  //       return Future.error(e.toString());
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  static Future<User?> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId');

  if (userId != null) {
    try {
      return await getDataUserFromServer(userId);
    } catch (e) {
      return Future.error(e.toString());
    }
  } else {
    return null;
  }
}


  // static Future<User?> dataUserProvider() async {
  //   try {
  //     return await getDataUserFromSharedPreferences();
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  final dataUserProvider = FutureProvider<User?>((ref) async {
    return await UserClient.getCurrentUser();
  });
  // static Future<bool> login(String username, String password) async {
  //    try {
  //      var response = await post(
  //        Uri.http(
  //            url, '/api/login'), // Sesuaikan dengan endpoint login pada API Anda
  //        body: {'username': username, 'password': password},
  //      );

  //      if (response.statusCode == 200) {
  //        // Jika respons status code adalah 200, artinya login berhasil
  //        return true;
  //      } else {
  //       // Jika respons status code tidak 200, artinya login gagal
  //        return false;
  //      }
  //    } catch (e) {
  //      // Tangani kesalahan yang mungkin terjadi selama proses login
  //      print('Error during login: $e');
  //      return false;
  //    }
  //  }
  // untuk hp
  // static final String url = '192.168.0.105';
  // static final String endpoint = '/GD_API_1097/public/api/User';

  // mengambil semua data User dari API
  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(
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
      var response =
          await http.get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek User berdasarkan bagian data dari response body
      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // membuat data User baru
  static Future<http.Response> create(User user) async {
    try {
      var response = await http.post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
       print('Response body: ${response.body}');
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mengubah data User sesuai id
  static Future<http.Response> update(User user) async {
    try {
      var response = await http.put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // mneghapus data User sesuai ID
  // static Future<Response> destroy(id) async {
  //   try {
  //     var response = await delete(Uri.http(url, '$endpoint/$id'));

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return response;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  static Future<User?> logintesting({
    required String username,
    required String password,
  }) async {
    String apiURL = 'http://127.0.0.1:8000/api/login';
    try {
      var apiResult = await http.post(
        Uri.parse(apiURL),
        body: {'username': username, 'password': password},
      );
      if (apiResult.statusCode == 200) {
        final result = User.fromRawJson(apiResult.body);
        return result;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      return null;
    }
  }
}
