// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Masukkan Password!';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password harus memiliki setidaknya satu angka!';
                    }
                    return null;
                  },
                  obscureText: true,
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
                  controller: _noHpController,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final password = _passwordController.text;
                      final email = _emailController.text;
                      final phone = _noHpController.text;
                      final gender = _genderController.text;
                    }
                    // Di sini Anda dapat menangani logika pendaftaran, misalnya, mengirimkan data ke server atau menyimpan dalam penyimpanan lokal.
                  },
                  child: Text('Daftar'),
                ),
              ],
            ),
          )),
    );
  }
}
