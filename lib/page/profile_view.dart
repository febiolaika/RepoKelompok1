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
  int noHp = 0;
  String gender = "";

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

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
      noHp = prefs.getInt('noHp') ?? 0;
      gender = prefs.getString('gender') ?? "No Gender";

      // Mengisi controller dengan data pengguna
      _usernameController.text = username;
      _emailController.text = email;
      _noHpController.text = noHp.toString();
      _genderController.text = gender;
    });
  }

  Future<void> saveUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setInt('noHp', int.parse(_noHpController.text));
    prefs.setString('gender', _genderController.text);
    setState(() {
      // Update data pengguna sesuai yang baru disimpan
      username = _usernameController.text;
      email = _emailController.text;
      noHp = int.parse(_noHpController.text);
      gender = _genderController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Panggil method untuk menyimpan perubahan data pengguna
              saveUserProfile();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Data profil berhasil diperbarui'),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _noHpController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
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
  
