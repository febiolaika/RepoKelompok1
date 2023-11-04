// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd6_1217/database/sql_helper_product.dart';
import 'package:ugd6_1217/page/product_input_page.dart';
import 'package:ugd6_1217/page/profile_view.dart';
import 'package:ugd6_1217/page/shake.dart';
import 'package:ugd6_1217/notification_widget.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        _setFloatingActionButton(null);
      } else {
        _setFloatingActionButton(FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductInput(
                  title: 'Input Product',
                  nama: null,
                  id: null,
                  durasi: null,
                  harga: null,
                  gambar: null,
                ),
              ),
            ).then((value) => refresh(''));
          },
          child: const Icon(Icons.add),
        ));
      }
    });
  }

  Widget? _floatingActionButton;

  void _setFloatingActionButton(Widget? fab) {
    setState(() {
      if (_selectedIndex == 0) {
        _floatingActionButton = fab;
      } else {
        _floatingActionButton = null;
      }
    });
  }

  List<Map<String, dynamic>> product = [];
  TextEditingController cariController = TextEditingController();
  void refresh(String cari) async {
    final data = await SQLHelperProduct.getProduct(cari);
    if (mounted) {
      setState(() {
        product = data;
      });
    }
  }

  @override
  void initState() {
    refresh('');
    _setFloatingActionButton(FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProductInput(
              title: 'Input Product',
              nama: null,
              id: null,
              durasi: null,
              harga: null,
              gambar: null,
            ),
          ),
        ).then((value) => refresh(''));
      },
      child: const Icon(Icons.add),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: cariController,
                  decoration: const InputDecoration(labelText: 'Cari Produk'),
                  onChanged: (value) => refresh(value),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  NotificationWidget.showNotification(
                    title: "Notifikasi",
                    body: 'Ini adalah notifikasi Login!',
                  );
                },
                child: Text('Tampilkan Notifikasi'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      child: ListTile(
                        title: Text(product[index]['nama']),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product[index]['harga'].toString()),
                            Text(product[index]['durasi'].toString()),
                          ],
                        ),
                      ),
                      actionPane: const SlidableDrawerActionPane(),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Update',
                          color: Colors.blue,
                          icon: Icons.update,
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductInput(
                                  title: 'EDIT PRODUCT',
                                  id: product[index]['id'],
                                  nama: product[index]['nama'],
                                  harga: product[index]['harga'],
                                  durasi: product[index]['durasi'],
                                  gambar: product[index]['gambar'],
                                ),
                              ),
                            ).then((_) => refresh(''));
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            await deleteProduct(product[index]['id'])
                                .then((_) => refresh(''));
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          const ShakeView(),
          const ProfileView(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Product'),
          BottomNavigationBarItem(icon: Icon(Icons.vibration), label: 'Shake'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Product',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  Future<void> deleteProduct(int id) async {
    await SQLHelperProduct.deleteProduct(id);
  }
}
