import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugd6_1217/database/sql_helper_product.dart';
import 'package:ugd6_1217/page/product_input_page.dart';
import 'package:ugd6_1217/page/profile_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int _selectedIndex = 0;

  List<Widget> _pages = [ProductView(), const ProfileView()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Pindah ke tab Profile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileView(),
        ),
      );
    }
  }

  List<Map<String, dynamic>> product = [];
  TextEditingController cariController = TextEditingController();
  void refresh(String cari) async {
    final data = await SQLHelperProduct.getProduct(cari);
    setState(() {
      product = data;
    });
  }

  @override
  void initState() {
    refresh('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductInput(
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
          child: Icon(Icons.add)
        ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: cariController,
                  decoration: InputDecoration(labelText: 'Cari Produk'),
                  onChanged: (value) => refresh(value),
                ),
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
                        trailing: Image.asset('images/' + product[index]['gambar'] + '.jpg'),
                      ),
                      actionPane: SlidableDrawerActionPane(),
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
                            await deleteProduct(product[index]['id']).then((_) => refresh(''));
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProfileView(),
                              ),
                            );
                          },
                          child: const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          const ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> deleteProduct(int id) async {
    await SQLHelperProduct.deleteProduct(id);
  }
}