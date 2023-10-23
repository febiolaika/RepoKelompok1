// ignore_for_file: avoid_print

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
  final int? id, durasi;
  final double? harga;

  @override
  State<ProductInput> createState() => _ProductInputState();
}

const List<String> imageDropdown = <String>[
  "images/rambut1.jpg",
  "images/kuku1.jpg"
];

class _ProductInputState extends State<ProductInput> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController durasiController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  String dropDown = imageDropdown.first;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  dropDown,
                  width: 200,
                  height: 150,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        iconSize: 0,
                        value: dropDown,
                        onChanged: (String? value) {
                          setState(() {
                            dropDown = value!;
                            // namaController.text = getDisplayText(value);
                          });
                        },
                        items: imageDropdown
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(getDisplayText(value)),
                          );
                        }).toList(),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
                TextFormField(
                  controller: namaController,
                  // readOnly: true,
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
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (widget.id == null) {
                          SQLHelperProduct.addProduct(
                              namaController.text,
                              double.parse(hargaController.text),
                              int.parse(durasiController.text),
                              gambarController.text);
                        } else {
                          SQLHelperProduct.editProduct(
                              widget.id!,
                              namaController.text,
                              double.parse(hargaController.text),
                              int.parse(durasiController.text),
                              gambarController.text);
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Simpan'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDisplayText(String value) {
    if (value == "images/rambut1.jpg") {
      return "Potong Rambut";
    } else if (value == "images/kuku1.jpg") {
      return "Nail Art";
    }
    return value;
  }
}
