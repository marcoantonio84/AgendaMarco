// lib/repositories/contact_repository.dart

import '../models/contact_model.dart';
import '../data/contact_database.dart';

class ContactRepository {
  // Método para criar um novo contato
  Future<Contact> create(Contact contact) async {
    final db = await ContactDatabase.instance.database;

    // Inserir no banco de dados
    final id = await db.insert('contacts', contact.toMap());

    // Retorna o contato com o id gerado
    return contact.copyWith(id: id);
  }

  // Método para ler todos os contatos, ordenados pelo nome
  Future<List<Contact>> readAllContacts() async {
    final db = await ContactDatabase.instance.database;

    // Ordenando por nome
    const orderBy = 'name ASC';

    // Consultando todos os contatos
    final result = await db.query('contacts', orderBy: orderBy);

    // Convertendo os resultados para uma lista de objetos Contact
    return result.map((json) => Contact.fromMap(json)).toList();
  }

  // Método para atualizar um contato existente
  Future<int> update(Contact contact) async {
    final db = await ContactDatabase.instance.database;

    // Atualizando o contato no banco de dados
    return db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  // Método para deletar um contato pelo ID
  Future<int> delete(int id) async {
    final db = await ContactDatabase.instance.database;

    // Deletando o contato pelo ID
    return db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método para ler um contato específico pelo ID
  Future<Contact?> readContact(int id) async {
    final db = await ContactDatabase.instance.database;

    // Consultando um contato específico pelo ID
    final maps = await db.query(
      'contacts',
      columns: ['id', 'name', 'phone', 'email'],
      where: 'id = ?',
      whereArgs: [id],
    );

    // Verificando se encontrou o contato e retornando-o, ou null se não encontrado
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
