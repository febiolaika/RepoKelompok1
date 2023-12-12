import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugd6_1217/client/BookingClient.dart';
import 'package:ugd6_1217/entity/Booking.dart';
import 'package:ugd6_1217/page/BookingView.dart';
import 'package:intl/intl.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key, this.id});
  final int? id;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final nomorponselController = TextEditingController();
  final tanggalbookingController = TextEditingController();
  final jamdatangController = TextEditingController();
  final jenislayananController = TextEditingController();
  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      //mencari data barang dari API dan menampilkan valuenya
      Booking res = await BookingClient.find(widget.id);
      setState(() {
        isLoading = false;
        namaController.value = TextEditingValue(text: res.nama);
        nomorponselController.value = TextEditingValue(text: res.nomorponsel);
        tanggalbookingController.value = TextEditingValue(text: res.tanggalbooking.toString());
        jamdatangController.value = TextEditingValue(text: res.jamdatang);
        jenislayananController.value = TextEditingValue(text: res.jenislayanan);
      });
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    //jika diberikan id, muat data sebelumnya
    if (widget.id != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    //aksi ketika form disubmit
    void onSubmit() async {
  if (!_formKey.currentState!.validate()) return;

  // Convert text values to appropriate types
  //double harga = double.parse(hargaController.text);

  // Create Product object
  Booking input = Booking(
    id: widget.id ?? 0,
    nama: namaController.text,
    nomorponsel: nomorponselController.text,
    tanggalbooking: DateTime.parse(tanggalbookingController.text),
    jamdatang: jamdatangController.text,
    jenislayanan: jenislayananController.text,
    // data: null
  );

  try {
    if (widget.id == null) {
      await BookingClient.create(input);
    } else {
      await BookingClient.update(input);
    }

    showSnackBar(context, 'Success', Colors.green);
    Navigator.pop(context);
  } catch (err) {
    showSnackBar(context, err.toString(), Colors.red);
    Navigator.pop(context);
  }
}



    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Tambah Booking" : "Edit Booking"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan nama',
                        ),
                        controller: namaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan Nomor Ponsel',
                        ),
                        controller: nomorponselController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan Jam Datang',
                        ),
                        controller: jamdatangController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan Jenis Layanan',
                        ),
                        controller: jenislayananController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              tanggalbookingController.text = picked.toLocal().toString();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[200],
                        ),
                        child: Text('Pilih Tanggal'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        child: Text(
                          widget.id == null ? 'Tambah' : 'Edit',
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShowDatePicker Demo'),
      ),
      body: Center(
        
      ),
    );
  }
}
