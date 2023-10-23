// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd6_1217/database/database_user.dart';
import 'package:ugd6_1217/entity/user.dart';
import 'package:ugd6_1217/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {super.key,
      required this.name,
      required this.password,
      required this.email,
      required this.noHp,
      required this.gender,
      required this.id});

  final String? name, password, email, gender;
  final int? noHp, id;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  int noHp = 0;
  TextEditingController _genderController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Load data pengguna dari SharedPreferences (jika ada)
    loadUserData();
  }

  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('name') ?? '';
    _passwordController.text = prefs.getString('password') ?? '';
    _emailController.text = prefs.getString('email') ?? '';
    noHp = prefs.getInt('noHp') ?? 0;
    _genderController.text = prefs.getString('gender') ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
                  decoration: InputDecoration(labelText: 'Nama'),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
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
                SizedBox(height: 20),
                TextFormField(
                  // controller: _noHpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Nomor Telepon'),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Jenis Kelamin (L/P)'),
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
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Daftar'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Periksa apakah email unik
                      bool isUniqueEmail =
                          await isEmailUnique(_emailController.text);

                      if (isUniqueEmail) {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('name', _nameController.text);
                        prefs.setString('password', _passwordController.text);
                        prefs.setString('email', _emailController.text);
                        prefs.setInt('noHp', noHp);
                        prefs.setString('gender', _genderController.text);

                        // Buat objek User
                        User newUser = User(
                          name: _nameController.text,
                          password: _passwordController.text,
                          email: _emailController.text,
                          noHp: noHp,
                          gender: _genderController.text,
                        );

                        // Tambahkan pengguna ke database
                        if (widget.id == null) {
                          await addUser();
                        } else {
                          await editUser(widget.id!);
                        }

                        // Redirect ke halaman login atau halaman lainnya
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              LoginView(), // Ganti dengan halaman login Anda
                        ));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Registrasi berhasil!'), // Pesan yang ingin ditampilkan
                          duration: Duration(seconds: 2), // Durasi pesan
                        ));
                      } else {
                        // Tampilkan pesan kesalahan jika email tidak unik
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Email sudah digunakan. Gunakan email lain.'),
                        ));
                      }
                    }
                  },
                )
              ],
            ),
          )),
    );
  }

  Future<bool> isEmailUnique(String email) async {
    // Periksa apakah email sudah ada di database
    List<Map<String, dynamic>> users = await USERHelper.getUser();
    bool isUnique = true;
    for (var user in users) {
      if (user['email'] == email) {
        isUnique = false;
        break;
      }
    }
    return isUnique;
  }

  Future<void> addUser() async {
    await USERHelper.addUser(_nameController.text, _passwordController.text,
        _emailController.text, noHp, _genderController.text);
  }

  Future<void> editUser(int id) async {
    await USERHelper.editUser(
        id,
        _nameController.text,
        _passwordController.text,
        _emailController.text,
        noHp,
        _genderController.text);
  }
}
