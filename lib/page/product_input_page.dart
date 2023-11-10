// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ugd6_1217/database/sql_helper_product.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:ugd6_1217/pdf_view.dart';

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
  String idd = const Uuid().v1();

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
            padding: EdgeInsets.all(2.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  dropDown,
                  width: 20.0.w,
                  height: 15.0.h,
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
                SizedBox(height: 2.0.h),
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
                    child: const Text('Simpan'),
                  ),
                  buttonCreatePDF(context),
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

  Container buttonCreatePDF(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0), // Adjust margin as needed
      child: ElevatedButton(
        onPressed: () {
          createPdf(
            namaController,
            hargaController,
            durasiController,
            idd,
            dropDown,
            context,
          );
          setState(() {
            const uuid = Uuid();
            idd = uuid.v1();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }
}
