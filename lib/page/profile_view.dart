import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd6_1217/database/database_user.dart';
import 'package:ugd6_1217/page/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String username = "";
  String email = "";
  String noHp = "";
  String gender = "";

  @override
  void initState() {
    super.initState();
    // Panggil method untuk mengambil data profil pengguna dari Shared Preferences saat halaman ini diinisialisasi.
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Mengambil data profil pengguna dari Shared Preferences
      username = prefs.getString('username') ?? "No Username";
      email = prefs.getString('email') ?? "No Email";
      noHp = prefs.getInt('noHp')?.toString() ?? "No Phone Number";
      gender = prefs.getString('gender') ?? "No Gender";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Username: $username'),
            Text('Email: $email'),
            Text('Phone Number: $noHp'),
            Text('Gender: $gender'),
            // Tambahkan widget lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}

// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

// }
  
