import 'package:flutter/material.dart';
import 'package:ugd6_1217/constant/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd6_1217/views/camera/camera.dart';
import 'package:ugd6_1217/views/camera/display_picture.dart';

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
            InkWell(
              onTap: () {
                // Tambahkan logika yang ingin Anda jalankan saat tombol diklik di sini
                ProfileView.navigateTo(context, RouteConstant.routeToQrCam);
              },
              child: CircleAvatar(
                radius: 50, // Atur sesuai ukuran yang Anda inginkan
                backgroundColor: Colors.blue, // Atur warna latar belakang sesuai keinginan Anda
                child: Icon(
                  Icons.camera_alt, // Gunakan ikon kamera (atau ikon lainnya) di sini
                  size: 50, // Atur ukuran ikon sesuai keinginan Anda
                  color: Colors.white, // Atur warna ikon sesuai keinginan Anda
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => ProfileView.navigateTo(
                  context, RouteConstant.routeToQrScanPage),
              child: const Text(ButtonTextConstant.qrScanning),
            ),
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
