import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugd6_1217/client/ProductClient.dart';
import 'package:ugd6_1217/entity/product.dart';
import 'package:ugd6_1217/page/ProductView.dart';
import 'package:ugd6_1217/pdf_view.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, this.id});
  final int? id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final durasiController = TextEditingController();
  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      //mencari data barang dari API dan menampilkan valuenya
      Product res = await ProductClient.find(widget.id);
      setState(() {
        isLoading = false;
        namaController.value = TextEditingValue(text: res.nama);
        hargaController.value = TextEditingValue(text: res.harga.toString());
        durasiController.value = TextEditingValue(text: res.durasi);
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
  double harga = double.parse(hargaController.text);

  // Create Product object
  Product input = Product(
    id: widget.id ?? 0,
    nama: namaController.text,
    harga: harga,
    durasi: durasiController.text,
    // data: null
  );

  try {
    if (widget.id == null) {
      await ProductClient.create(input);
    } else {
      await ProductClient.update(input);
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
        title: Text(widget.id == null ? "Tambah Produk" : "Edit Produk"),
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
                          labelText: 'Masukkan Harga',
                        ),
                        controller: hargaController,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan Durasi',
                        ),
                        controller: durasiController,
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
                     // Tombol untuk membuka PDF
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Panggil fungsi createPdf untuk membuka PDF
                          createPdf(
                            namaController,
                            hargaController,
                            durasiController,
                            widget.id.toString(),
                            "DropDownValue", // Ganti dengan nilai sesuai kebutuhan
                            context,
                          );
                        },
                        child: Text('Buka PDF'),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
