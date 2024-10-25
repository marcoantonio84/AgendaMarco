import 'package:sqflite/sqflite.dart';
import 'contact_database.dart';

class LoginRepository {
  // Função de registro (cadastro)
  Future<bool> register(String username, String password) async {
    final db = await ContactDatabase.instance.database;

    // Verificar se o usuário já existe
    final existingUser = await db.query(
      'login',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (existingUser.isNotEmpty) {
      // Se o usuário já existe, retorna falso
      return false;
    }

    // Tente inserir o novo usuário
    try {
      await db.insert('login', {
        'username': username,
        'password': password,
      });
      return true; // Cadastro realizado com sucesso
    } catch (e) {
      print("Erro ao cadastrar usuário: $e");
      return false;
    }
  }

  // Função de login
  Future<bool> login(String username, String password) async {
    final db = await ContactDatabase.instance.database;

    // Consultar se o usuário e senha existem
    try {
      final result = await db.query(
        'login',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );

      return result.isNotEmpty;  // Retorna verdadeiro se o login for bem-sucedido
    } catch (e) {
      print("Erro ao fazer login: $e");
      return false;
    }
  }
}
