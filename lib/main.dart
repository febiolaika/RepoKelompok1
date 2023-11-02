import 'package:flutter/material.dart';
import 'package:ugd6_1217/page/login_page.dart';

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
        // '/register': (context) => const RegisterView(),
      },
    );
  }
}
