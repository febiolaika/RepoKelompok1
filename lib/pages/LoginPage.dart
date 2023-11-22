// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_api_1/pages/RegisterPage.dart';
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
                    onPressed: () async {
                      final username = _usernameController.text;
                      final password = _passwordController.text;

                      try {
                        // Kirim permintaan ke endpoint login
                        final response = await http.post(
                          Uri.parse('http://10.0.2.2:8000/login'),
                          body: {'username': username, 'password': password},
                        );

                        // Periksa respons dari server
                        if (response.statusCode == 200) {
                          print('Login berhasil');
                          // Login berhasil
                          // Lakukan navigasi atau tindakan lain yang diperlukan
                        } else {
                          // Login gagal
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Login Gagal'),
                                content:
                                    const Text('Username atau password salah.'),
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
                      } catch (e) {
                        print('Error during login: $e');
                      }
                    },
                    child: const Text('Login')),
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
