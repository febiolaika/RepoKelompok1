import 'package:flutter/material.dart';
import 'package:ugd6_1217/constant/app_constant.dart';
import 'package:ugd6_1217/page/login_page.dart';
import 'package:ugd6_1217/page/product_view.dart';
import 'package:ugd6_1217/views/camera/camera.dart';
import 'package:ugd6_1217/views/qr_scan/scan_qr_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        RouteConstant.routeToQrCam: (context) => CameraView(),
        RouteConstant.routeToQrScanPage: (context) => BarcodeScannerPageView(),
        // '/register': (context) => const RegisterView(),
      },
    );
  }
}
