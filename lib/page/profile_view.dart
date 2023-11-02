import 'package:flutter/material.dart';
import 'package:ugd6_1217/constant/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  static void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

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
            ElevatedButton(
              onPressed: () =>
                  ProfileView.navigateTo(context, RouteConstant.routeToQrCam),
              child: const Text(ButtonTextConstant.camera),
            ),
            ElevatedButton(
              onPressed: () => ProfileView.navigateTo(
                  context, RouteConstant.routeToQrScanPage),
              child: const Text(ButtonTextConstant.qrScanning),
            ),
            // Tambahkan widget lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}

// class ProfileView extends StatefulWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   static void navigateTo(BuildContext context, String routeName) =>
//       Navigator.pushNamed(context, routeName);

//   @override
//   _ProfileViewState createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   String username = "";
//   String email = "";
//   String noHp = "";
//   String gender = "";

//   @override
//   void initState() {
//     super.initState();
//     getUserProfile();
//   }

//   Future<void> getUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       // Mengambil data profil pengguna dari Shared Preferences
//       username = prefs.getString('username') ?? "No Username";
//       email = prefs.getString('email') ?? "No Email";
//       noHp = prefs.getInt('noHp')?.toString() ?? "No Phone Number";
//       gender = prefs.getString('gender') ?? "No Gender";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Username: $username'),
//             Text('Email: $email'),
//             Text('Phone Number: $noHp'),
//             Text('Gender: $gender'),
//             ElevatedButton(
//               onPressed: () => navigateTo(context, RouteConstant.routeToQrCam),
//               child: const Text(ButtonTextConstant.camera),
//             ),
//             ElevatedButton(
//               onPressed: () =>
//                   navigateTo(context, RouteConstant.routeToQrScanPage),
//               child: const Text(ButtonTextConstant.qrScanning),
//             ),
//             // Tambahkan widget lain sesuai kebutuhan
//           ],
//         ),
//       ),
//     );
//   }
// }

//  navigateTo(BuildContext context, String routeToQrCam) 
