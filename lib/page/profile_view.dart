import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String username = '';
  String email = '';
  int? noHp = 0;
  String gender = '';

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  Future<void> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Mengambil data profil pengguna dari Shared Preferences
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      noHp = prefs.getInt('noHp');
      gender = prefs.getString('gender')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(username),
            Text(noHp.toString()),
          ],
        ),
      ),
    );
  }
}
