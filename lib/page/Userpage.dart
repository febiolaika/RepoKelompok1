import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_1217/client/UserClient.dart';
import 'package:ugd6_1217/entity/user.dart';
import 'package:ugd6_1217/page/RegisterPage.dart';

class Userpage extends ConsumerWidget {
  Userpage({super.key});

  //provider untuk mengambil list data User dari API
  // final listUserProvider = FutureProvider<List<User>>((ref) async {
  //   return await UserClient.fetchAll();
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data User"),
      ),
    );
  }
}