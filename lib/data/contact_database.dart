import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  static final ContactDatabase instance = ContactDatabase._init();

  static Database? _database;

  ContactDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone TEXT NOT NULL,
      email TEXT NOT NULL
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
