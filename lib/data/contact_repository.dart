import '../contact_model.dart';
import 'data/contact_database.dart';

class ContactRepository {
  Future<Contact> create(Contact contact) async {
    final db = await ContactDatabase.instance.database;

    final id = await db.insert('contacts', contact.toMap());
    return contact.copyWith(id: id);
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await ContactDatabase.instance.database;

    const orderBy = 'name ASC';
    final result = await db.query('contacts', orderBy: orderBy);

    return result.map((json) => Contact.fromMap(json)).toList();
  }

  Future<int> update(Contact contact) async {
    final db = await ContactDatabase.instance.database;

    return db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await ContactDatabase.instance.database;

    return db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Contact?> readContact(int id) async {
    final db = await ContactDatabase.instance.database;

    final maps = await db.query(
      'contacts',
      columns: ['id', 'name', 'phone', 'email'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
