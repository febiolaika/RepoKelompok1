// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd6_1217/client/UserClient.dart';
import 'package:ugd6_1217/entity/User.dart';
import 'package:ugd6_1217/page/LoginPage.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {super.key,
      required this.name,
      required this.password,
      required this.email,
      required this.noHp,
      required this.gender,
      required this.id});

  final String? name, password, email, noHp, gender;
  final int? id;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), labelText: 'Nama'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Username!';
                      }
                      if (value.length < 6) {
                        return 'Username harus memiliki setidaknya 6 karakter!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.0.h),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Password!';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password harus memiliki setidaknya satu angka!';
                      }
                      return null;
                    },
                    obscureText: !isPasswordVisible,
                  ),
                  SizedBox(height: 2.0.h),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan email!';
                      }
                      if (!value.contains('@')) {
                        return 'Email harus menggunakan @!';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 2.0.h),
                  TextFormField(
                    controller: _noHpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Nomor Telepon'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan No HP!';
                      }
                      if (value.length < 12) {
                        return 'No HP harus berisi 12 angka!';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 2.0.h),
                  TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.face),
                        labelText: 'Jenis Kelamin (L/P)'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan gender!';
                      }
                      if (value != "L" && value != "P") {
                        return 'Gender harus diisi dengan L atau P!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 2.0.h),
                  ElevatedButton(
                    child: Text('Daftar'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User newUser = User(
                          id: widget.id ?? 0,
                          username: _nameController.text,
                          password: _passwordController.text,
                          email: _emailController.text,
                          noHp: _noHpController.text,
                          gender: _genderController.text,
                          data: null,
                        );
                        try {
                          var response = await UserClient.create(newUser);

                          if (response.statusCode == 201 ||
                              response.statusCode == 200) {
                            // Data tersimpan dengan sukses
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registrasi Berhasil'),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          } else {
                            // Handle status code selain 201 atau 200
                            print(
                                'Gagal menyimpan data, status code: ${response.statusCode}');
                          }
                        } catch (e) {
                          print('Registrasi gagal: $e');
                        }
                      }
                    },
                  ),
                ],
              ),
            )),
      );
    });
  }
}
