class Product {
  final int? id;
  final String? nama;
  final int? harga;
  final int? durasi;

  Product({this.nama, this.harga, this.durasi, this.id});

  @override
  String toString() {
    return 'Produk{name: $nama}';
  }
}