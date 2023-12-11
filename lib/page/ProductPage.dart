import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugd6_1217/client/ProductClient.dart';
import 'package:ugd6_1217/entity/product.dart';
import 'package:ugd6_1217/page/ProductView.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, this.id, this.idUser});
  final int? id;
  final int? idUser;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final imageController = TextEditingController();
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
        nameController.value = TextEditingValue(text: res.name);
        priceController.value = TextEditingValue(text: res.price.toString());
        durationController.value = TextEditingValue(text: res.duration.toString());
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
  double price = double.parse(priceController.text);
  int duration = int.parse(durationController.text);

  // Create Product object
  Product input = Product(
    id: widget.id ?? 0,
    idUser: widget.idUser ?? 0,
    name: nameController.text,
    price: price.toString(),
    duration: duration.toString(),
    image: imageController.text,
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
                        controller: nameController,
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
                        controller: priceController,
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
                        controller: durationController,
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
                    )
                  ],
                )),
      ),
    );
  }
}
