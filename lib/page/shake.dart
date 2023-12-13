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
