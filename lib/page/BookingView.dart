import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ugd6_1217/client/BookingClient.dart';
import 'package:ugd6_1217/entity/Booking.dart';
import 'package:ugd6_1217/page/BookingPage.dart';
import 'package:ugd6_1217/page/shake.dart';
import 'package:ugd6_1217/page/UserPage.dart';
import 'package:ugd6_1217/page/ProductView.dart';

class BookingView extends ConsumerWidget {
  BookingView({super.key});

  //provider untuk mengambil list data barang dari API
  final listBookingProvider = FutureProvider<List<Booking>>((ref) async {
    return await BookingClient.fetchAll();
  });

  //aksi ketika floating button ditekan
  void onAdd(context, ref) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BookingPage())).then((value) => ref.refresh(
        listBookingProvider)); //refresh list data barang ketika kembali ke halaman ini
  }

  //aksi ketika tombol delete ditekan
  void onDelete(id, context, ref) async {
    try {
      await BookingClient.destroy(id); // menghapus data barang berdasarkan id
      ref.refresh(listBookingProvider);
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  //widget untuk item dalam list
  ListTile scrollViewItem(Booking booking, context, ref) => ListTile(
      title: Text(booking.nama),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nomor Ponsel: ${booking.nomorponsel}"),
          Text("Tanggal Booking: ${DateFormat('yyyy-MM-dd').format(booking.tanggalbooking)}"), // Format the date
          Text("Jam Datang: ${booking.jamdatang}"),
          Text("Jenis Layanan: ${booking.jenislayanan}"),
        ],
      ),
      onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingPage(id: booking.id)))
          .then((value) => ref.refresh(listBookingProvider)),
      trailing: IconButton(
          onPressed: () => onDelete(booking.id, context, ref),
          icon: const Icon(Icons.delete)));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listBookingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(context, ref),
      ),
      body: listener.when(
        data: (bookings) => SingleChildScrollView(
          child: Column(
              children: bookings
                  .map((booking) => scrollViewItem(booking, context, ref))
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
            icon: Icon(Icons.date_range),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.yellow[700], // Change the color based on your theme
        backgroundColor: Colors.pink[300], // Change the color based on your theme
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductView(),
                ),
              );
              break;
            case 1:
              
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
