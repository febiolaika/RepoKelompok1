// ignore_for_file: file_names

import 'dart:convert';

class Booking {
  int id;
  String nama;
  String nomorponsel;
  DateTime tanggalbooking;
  String jamdatang;
  String jenislayanan;
  //final Map<String, dynamic>? data;

  Booking({
    required this.id,
    required this.nama,
    required this.nomorponsel,
    required this.tanggalbooking,
    required this.jamdatang,
    required this.jenislayanan,
    //required this.data,
  });

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));
  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
      id: json["id"],
      nama: json["nama"],
      nomorponsel: json["nomorponsel"],
      tanggalbooking: DateTime.parse(json["tanggalbooking"]),
      jamdatang: json["jamdatang"], 
      jenislayanan: json["jenislayanan"],
      //data: json["data"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nomorponsel": nomorponsel,
        "tanggalbooking": tanggalbooking.toIso8601String(),
        "jamdatang": jamdatang,
        "jenislayanan": jenislayanan,
        //"data": data,
      };
}
