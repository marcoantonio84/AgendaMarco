import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabase {
  // Singleton para garantir que a instância seja única.
  static final ContactDatabase instance = ContactDatabase._init();

  static Database? _database;

  ContactDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    await Directory(dbPath).create(recursive: true); // Garante que o diretório existe.
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Cria a tabela "contacts"
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  // Método para inserir um novo contato
  Future<int> createContact(Map<String, dynamic> contact) async {
    final db = await instance.database;
    return await db.insert('contacts', contact);
  }

  // Método para buscar todos os contatos
  Future<List<Map<String, dynamic>>> readAllContacts() async {
    final db = await instance.database;
    return await db.query('contacts');
  }

  // Método para buscar um contato específico pelo ID
  Future<Map<String, dynamic>?> readContact(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'contacts',
      columns: ['id', 'name', 'phone', 'email'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null; // Retorna null se o contato não for encontrado
    }
  }

  // Método para atualizar um contato
  Future<int> updateContact(int id, Map<String, dynamic> contact) async {
    final db = await instance.database;
    return await db.update(
      'contacts',
      contact,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método para excluir um contato
  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método para fechar o banco de dados com segurança
  Future close() async {
    final db = await instance.database;
    if (db.isOpen) {
      await db.close();
    }
  }
}
