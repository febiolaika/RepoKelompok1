// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_1217/page/RegisterPage.dart';
import 'package:ugd6_1217/client/UserClient.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/page/RegisterPage.dart';
import 'package:ugd6_1217/entity/User.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 2.0.h),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isPasswordVisible ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !isPasswordVisible,
                ),
                SizedBox(height: 2.0.h),
                ElevatedButton(
  child: const Text('Login'),
  onPressed: () async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final http.Client client = http.Client(); // Create an instance of http.Client

      final LoginModel? loginResult = await UserClient.login(
        username: username,
        password: password,
        client: client, // Pass the http.Client instance
      );

      if (loginResult != null) {
        if (loginResult.status == true) {
          // Login berhasil
          print('Login berhasil');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductView(),
            ),
          );
        } else {
          // Login gagal
          print(loginResult.message);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Login Gagal'),
                content: Text(loginResult.message ?? 'Terjadi kesalahan.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle the case where loginResult is null
        
        print('Status: ${loginResult?.status}');
        print('Login result is null');
      }

      // Make sure to close the http.Client after using it
      client.close();
    } catch (e) {
      // Tangani error
      print('Error saat login: $e');
    }
  },
),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum mempunyai akun?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterView(
                              name: null,
                              password: null,
                              email: null,
                              noHp: null,
                              gender: null,
                              id: null,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
