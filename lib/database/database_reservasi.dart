import 'package:sqflite/sqflite.dart' as sql;

class RESERVASIHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE reservasi(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        jenisLayanan TEXT,
        price NUMERIC
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('reservasi.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addObject(String jenisLayanan, double price) async {
    final db = await RESERVASIHelper.db();
    final data = {'jenisLayanan': jenisLayanan, 'price': price};
    return await db.insert('', data);
  }

  static Future<List<Map<String, dynamic>>> getObject() async {
    final db = await RESERVASIHelper.db();
    return db.query('reservasi');
  }

  static Future<int> editObject(
      int id, String jenisLayanan, double price) async {
    final db = await RESERVASIHelper.db();
    final data = {'jenisLayanan': jenisLayanan, 'price': price};
    return await db.update('reservasi', data, where: "id = $id");
  }

  static Future<int> dataObject(int id) async {
    final db = await RESERVASIHelper.db();
    return await db.delete('reservasi', where: "id = $id");
  }
}
