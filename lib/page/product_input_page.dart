import 'package:flutter/material.dart';
import 'package:ugd6_1217/database/sql_helper_product.dart';

class ProductInput extends StatefulWidget {
  const ProductInput(
      {super.key,
      required this.title,
      required this.id,
      required this.nama,
      required this.harga,
      required this.durasi,
      required this.gambar});
  final String? title, nama, gambar;
  final int? id, harga, durasi;

  @override
  State<ProductInput> createState() => _ProductInputState();
}

class _ProductInputState extends State<ProductInput> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController durasiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      namaController.text = widget.nama!;
      hargaController.text = widget.harga!.toString();
      durasiController.text = widget.durasi!.toString();
    }
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama'),
                ),
                TextFormField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Harga'),
                ),
                TextFormField(
                  controller: durasiController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Durasi'),
                ),
                TextFormField(
                  controller: gambarController,
                  decoration: InputDecoration(labelText: 'Gambar'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (widget.id == null) {
                          await addProduct();
                        } else {
                          await editProduct(widget.id!);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Simpan'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    try {
      await SQLHelperProduct.addProduct(
        namaController.text,
        int.parse(hargaController.text),
        int.parse(durasiController.text), gambarController.text
      );
    } catch (e) {
      print('Error parsing int');
    }
  }

  Future<void> editProduct(int id) async {
    try {
      await SQLHelperProduct.editProduct(id, namaController.text,
          int.parse(hargaController.text), int.parse(durasiController.text), gambarController.text);
    } catch (e) {
      print('Error parsing int');
    }
  }
}
