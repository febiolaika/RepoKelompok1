import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_1217/client/UserClient.dart';
import 'package:ugd6_1217/entity/user.dart';
import 'package:ugd6_1217/page/RegisterPage.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/page/shake.dart';

class Userpage extends ConsumerWidget {
  Userpage({super.key});

  //provider untuk mengambil list data User dari API
  final dataUserProvider = FutureProvider<User>((ref) async {
  // Your asynchronous logic to fetch or create the User data
  // For example, fetching from SharedPreferences or an API
  // Replace this with your actual logic

  // Simulating asynchronous delay
  await Future.delayed(Duration(seconds: 2));

  // Replace the following line with your actual data fetching logic
  // This is just a placeholder
  final User user = User(id: 1, username: 'example', email: 'example@email.com', password: 'password', noHp: '1234567890', gender: 'Male', data: {});

  return user;
});
  // final listUserProvider = FutureProvider<List<User>>((ref) async {
  //   return await UserClient.fetchAll();
  // });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data User"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vibration),
            label: 'Shake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue, // Change the color based on your theme
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductView(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShakeView(),
                ),
              );
              break;
            case 2:
              
              break;
          }
        },
      ),
    );
  }
}