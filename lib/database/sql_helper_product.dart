import 'package:flutter/src/widgets/editable_text.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperProduct {
  SQLHelperProduct(
      TextEditingController namaController,
      TextEditingController hargaController,
      TextEditingController durasiController,
      TextEditingController gambarController);

  //create db
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE product(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nama TEXT,
      harga REAL,
      durasi INTEGER,
      gambar TEXT
      )
    """);
  }

  //call db
  static Future<sql.Database> db() async {
    return sql.openDatabase('product.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //insert Product
  static Future<int> addProduct(
      String nama, double harga, int durasi, String gambar) async {
    final db = await SQLHelperProduct.db();
    final data = {
      'nama': nama,
      'harga': harga,
      'durasi': durasi,
      'gambar': gambar
    };
    return await db.insert('product', data);
  }

  //read Product
  static Future<List<Map<String, dynamic>>> getProduct(String cari) async {
    final db = await SQLHelperProduct.db();
    return db.query('product', where: 'nama LIKE ?', whereArgs: ['$cari%']);
  }

  //update Product
  static Future<int> editProduct(
      int id, String nama, double harga, int durasi, String gambar) async {
    final db = await SQLHelperProduct.db();
    final data = {
      'nama': nama,
      'harga': harga,
      'durasi': durasi,
      'gambar': gambar
    };
    return await db.update('product', data, where: "id = ?", whereArgs: [id]);
  }

  //delete Product
  static Future<int> deleteProduct(int id) async {
    final db = await SQLHelperProduct.db();
    return await db.delete('product', where: "id = $id");
  }
}
