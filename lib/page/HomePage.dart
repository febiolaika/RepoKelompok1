// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:ugd_api_1/client/UserClient.dart';
// import 'package:ugd_api_1/entity/User.dart';
// // import 'package:ugd_api_1/pages/EditProduk.dart';

// class HomePage extends ConsumerWidget {
//   HomePage({super.key});

//   final listUserProvider = FutureProvider<List<User>>((ref) async {
//     return await UserClient.fetchAll();
//   });

//   void onAdd(context, ref) {
//     Navigator.push(context,
//             MaterialPageRoute(builder: (context) => const EditProduct()))
//         .then((value) => ref.refresh(listProductProvider));
//   }

//   void onDelete(id, context, ref) async {
//     try {
//       await UserClient.destroy(id);
//       ref.refresh(listUserProvider);
//       showSnackBar(context, "Delete Success", Colors.green);
//     } catch (e) {
//       showSnackBar(context, e.toString(), Colors.red);
//     }
//   }

//   ListTile scrollViewItem(User b, context, ref) => ListTile(
//         title: Text(b.nama),
//         subtitle: Text(b.deskripsi),
//         onTap: () => Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => EditUser(id: b.id)))
//             .then((value) => ref.refresh(listUserProvider)),
//         trailing: IconButton(
//             onPressed: () => onDelete(b.id, context, ref),
//             icon: const Icon(Icons.delete)),
//       );

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var listener = ref.watch(listUserProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("GD API 1217"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () => onAdd(context, ref),
//       ),
//       body: listener.when(
//         data: (products) => SingleChildScrollView(
//           child: Column(
//               children: productss
//                   .map((product) => scrollViewItem(product, context, ref))
//                   .toList()),
//         ),
//         error: (err, s) => Center(child: Text(err.toString())),
//         loading: () => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }

// //show Snackbar
// void showSnackBar(BuildContext context, String msg, Color bg) {
//   final scaffold = ScaffoldMessenger.of(context);
//   scaffold.showSnackBar(
//     SnackBar(
//       content: Text(msg),
//       backgroundColor: bg,
//       action: SnackBarAction(
//           label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
//     ),
//   );
// }