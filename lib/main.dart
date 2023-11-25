import 'package:flutter/material.dart';
import 'package:ugd6_1217/constant/app_constant.dart';
import 'package:ugd6_1217/page/LoginPage.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/page/product_view.dart';
import 'package:ugd6_1217/views/camera/camera.dart';
import 'package:ugd6_1217/views/qr_scan/scan_qr_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd6_1217/page/Userpage.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  // Future pickImageC() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);

  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     debugPrint('Failed to pick image : $e');
  //   }
  // }

  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      Device.orientation == Orientation.portrait
          ? Container(
              //Portrait
              width: 100.w,
              height: 12.5.h,
            )
          : Container(
              // Landscape
              width: 100.w,
              height: 12.5.h,
            );
      Device.screenType == ScreenType.tablet
          ? Container(
              // Tablet
              width: 100.w,
              height: 12.5,
            )
          : Container(
              // Mobile
              width: 100.w,
              height: 12.5.h,
            );
      return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginView(),
          RouteConstant.routeToQrCam: (context) => CameraView(),
          RouteConstant.routeToQrScanPage: (context) =>
              BarcodeScannerPageView(),
          // '/register': (context) => const RegisterView(),
          // Future pickImage() async {
          //   try {
          //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

          //     if (image == null) return;

          //     final imageTemp = File(image.path);
          //     setState(() => this.image = imageTemp);
          //   } on PlatformException catch (e) {
          //     debugPrint('Failed to pick image : $e');
          //   }
          // }
        },
      );
    });
  }
}

