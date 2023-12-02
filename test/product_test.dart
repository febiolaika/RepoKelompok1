import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_1217/client/ProductClient.dart';

void main() {
  test('login success', () async {
    final hasil = await ProductClient.productTesting(
        nama: 'david', harga: 2000, durasi: 20);
    expect(hasil?.data.nama, equals('david'));
    expect(
        double.parse(hasil?.data.harga), greaterThan(0)); // Matcher for 'harga'
    expect(
        int.parse(hasil?.data.durasi), greaterThan(0)); // Matcher for 'durasi'
  });

  test('login failed', () async {
    final result = await ProductClient.productTesting(
        nama: 'invalid', harga: 0, durasi: 0);
    expect(result, null);
  });
}
