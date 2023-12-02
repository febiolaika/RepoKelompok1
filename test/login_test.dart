import 'package:flutter_test/flutter_test.dart';
import 'package:ugd6_1217/client/UserClient.dart';

void main() {
  test('login success', () async {
    final hasil =
        await UserClient.logintesting(username: 'david', password: 'david123');
    expect(hasil?.data.username, equals('david'));
    expect(hasil?.data.password, equals('david123'));
  });

  test('login failed', () async {
    final result =
        await UserClient.logintesting(username: 'invalid', password: 'invalid');
    expect(result, null);
  });
}
