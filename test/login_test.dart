import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_1217/client/UserClient.dart';

void main() {
  test('login success', () async {
    final hasil = await UserClient.logintesting(
        username: 'David_11097', password: 'd_1097');
    expect(hasil?., matcher)
    expect(hasil?.data.username, equals('David_11097'));
    expect(hasil?.data.password, equals('d_1097'));
  });

  test('login failed', () async {
    final result =
        await UserClient.logintesting(username: 'invalid', password: 'invalid');
    expect(result, null);
  });
}
