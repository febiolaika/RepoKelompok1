import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_1217/client/UserClient.dart';
import 'package:ugd6_1217/entity/user.dart';
import 'package:ugd6_1217/page/BookingView.dart';
import 'package:ugd6_1217/page/RegisterPage.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/page/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userpage extends ConsumerWidget {
  Userpage({super.key});

  //provider untuk mengambil list data User dari API
  final dataUserProvider = FutureProvider<User>((ref) async {
  // Retrieve user data from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Example: Reading user data from SharedPreferences
  final int? userId = prefs.getInt('userId');
  final String? username = prefs.getString('username');
  final String? email = prefs.getString('email');
  final String? password= prefs.getString('password');
  final String? noHp = prefs.getString('noHp');
  final String? gender = prefs.getString('gender');
  // Add more fields as needed

  // Create a User object with the retrieved data
  User user = User(
    id: userId ?? 0, // Use a default value if the data is not available
    username: username ?? 'default', // Use a default value if the data is not available
    email: email ?? 'default@mail.com',
    password: password ?? 'xxx',
    noHp: noHp ?? '123123123123',
    gender: gender ?? 'L',
    // Add more fields as needed
  );

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
      body: FutureBuilder<User?>(
  future: ref.watch(dataUserProvider.future),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
      // User data is available
      User? user = snapshot.data;
      if (user != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}'),
            Text('Username: ${user.username}'),
            Text('Email: ${user.email}'),
            Text('No HP: ${user.noHp}'),
            Text('Gender: ${user.gender}'),
            // Display more user data fields as needed
            // ...
          ],
        );
      } else {
        return Text('User data is null');
      }
    } else {
      return Text('No data available');
    }
  },
),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.yellow[700], // Change the color based on your theme
        backgroundColor: Colors.pink[300], // Change the color based on your theme
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
                  builder: (context) => BookingView(),
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