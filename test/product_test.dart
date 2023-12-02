import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_1217/client/ProductClient.dart';

void main() {
  test('input success', () async {
    final hasil =
        await ProductClient.productTesting(nama: 'xxx', harga: 200, durasi: 20);
    expect(hasil?.data.nama, equals('xxx'));
    expect(hasil?.data.harga, equals(200)); // Matcher for 'harga'
    expect(hasil?.data.harga, equals(20)); // Matcher for 'durasi'
  });

  test('login failed', () async {
    final result = await ProductClient.productTesting(
        nama: 'invalid', harga: 0, durasi: 0);
    expect(result, null);
  });
}
