import 'package:sqflite/sqflite.dart' as sql;

class USERHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        password TEXT,
        email TEXT,
        noHp INTEGER,
        gender TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addUser(String username, String password, String email, int noHp, String gender) async {
    final db = await USERHelper.db();
    final data = {'username': username,'password': password, 'email': email, 'noHp': noHp, 'gender': gender};
    return await db.insert('user', data);
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await USERHelper.db();
    return db.query('user');
  }

  static Future<int> editUser(
      int id, String username, String password, String email, int noHp, String gender) async {
    final db = await USERHelper.db();
    final data = {'username': username,'password': password, 'email': email, 'noHp': noHp, 'gender': gender};
    return await db.update('user', data, where: "id = $id");
  }

  static Future<int> dataUser(int id) async {
    final db = await USERHelper.db();
    return await db.delete('user', where: "id = $id");
  }
}