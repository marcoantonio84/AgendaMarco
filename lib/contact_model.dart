class Contact {
  int? id;
  String name;
  String phone;
  String email;

  Contact({this.id, required this.name, required this.phone, required this.email});

  // Converter um objeto Contact em Map (para inserir no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // Criar um objeto Contact a partir de um Map (para buscar do banco de dados)
  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  Contact copyWith({int? id, String? name, String? phone, String? email}) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}
