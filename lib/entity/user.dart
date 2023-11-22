import 'dart:convert';

class User {
  final int? noHp, id;

  String? name, email, password, gender;

  User({this.id, this.name, this.password, this.email, this.noHp, this.gender});

  //untuk membuat objek User dari data json yang diterima dari API
  factory User.fromRawJson(String str) => User.fromRawJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        noHp: json["noHp"],
        gender: json["gender"],
      );

  //untuk membuat data json dari objek User yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "noHp": noHp,
        "gender": gender,
      };
}
