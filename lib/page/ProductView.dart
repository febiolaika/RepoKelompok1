import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ugd6_1217/client/ProductClient.dart';
import 'package:ugd6_1217/entity/Product.dart';
import 'package:ugd6_1217/page/ProductPage.dart';
import 'package:ugd6_1217/page/shake.dart';
import 'package:ugd6_1217/page/Userpage.dart';

class ProductView extends ConsumerWidget {
  ProductView({super.key});

  //provider untuk mengambil list data barang dari API
  final listProductProvider = FutureProvider<List<Product>>((ref) async {
    return await ProductClient.fetchAll();
  });

  //aksi ketika floating button ditekan
  void onAdd(context, ref) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => 
                const ProductPage())).then((value) => ref.refresh(
        listProductProvider)); //refresh list data barang ketika kembali ke halaman ini
  }

  //aksi ketika tombol delete ditekan
  void onDelete(id, context, ref) async {
    try {
      await ProductClient.destroy(id); // menghapus data barang berdasarkan id
      ref.refresh(listProductProvider);
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  //widget untuk item dalam list
  ListTile scrollViewItem(Product product, context, ref) => ListTile(
      title: Text(product.nama),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Harga: ${product.harga.toStringAsFixed(2)}"), // Convert double to String
            Text("Durasi: ${product.durasi.toString()}"),
          ],
        ),
      onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductPage(id: product.id)))
          .then((value) => ref.refresh(listProductProvider)),
      trailing: IconButton(
          onPressed: () => onDelete(product.id, context, ref),
          icon: const Icon(Icons.delete)));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listProductProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(context, ref),
      ),
      body: listener.when(
        data: (products) => SingleChildScrollView(
          child: Column(
              children: products
                  .map((product) => scrollViewItem(product, context, ref))
                  .toList()),
        ), //muncul ketika data berhasil diambil
        error: (err, s) =>
            Center(child: Text(err.toString())), //mucul ketika error
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vibration),
            label: 'Shake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue, // Change the color based on your theme
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              // Navigate to the product page
              break;
            case 1:
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShakeView(),
                ),
              );
              break;
            case 2:
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Userpage(),
                ),
              );
              break;
          }
        },
       ),
    ); 
  }
}

// untuk menampilkan snackbar
  void showSnackBar(BuildContext context, String msg, Color bg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bg,
        action: SnackBarAction(
            label: 'hide', onPressed: Scaffold.hideCurrentSnackBar),
      ),
    );
  }