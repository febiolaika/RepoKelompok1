import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_1217/page/BookingView.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/page/Userpage.dart';

class ShakeView extends StatefulWidget {
  const ShakeView({Key? key}) : super(key: key);

  @override
  State<ShakeView> createState() => _ShakeViewState();
}

class _ShakeViewState extends State<ShakeView> {
  int shakeCounter = 0;
  double threshold = 3.0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      double angularVelocity = event.y;

      if (angularVelocity.abs() > threshold) {
        setState(() {
          shakeCounter++;
          if (shakeCounter >= 5) {
            navigateToGoogleMaps();
            shakeCounter = 0; // Reset counter setelah navigasi
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Shake Device"),
          ),
          body: Center(
            child: Text("Shake Count $shakeCounter"),
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
            icon: Icon(Icons.vibration),
            label: 'Shake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 3,
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
                  builder: (context) => BookingView(),
                ),
              );
              break;
            case 2:
              
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Userpage(),
                ),
              );
              break;
          }
        },
      ),
        ),
      );
    });
  }

  void navigateToGoogleMaps() {
    MapsLauncher.launchCoordinates(
      -7.778898608373376, // Latitude
      110.41620419895762, // Longitude
      'Salon', // Nama lokasi (opsional)
    );
  }
}
