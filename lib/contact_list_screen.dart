import 'package:flutter/material.dart';
import 'contact_form_screen.dart';
import 'contact_model.dart';
import 'data/contact_repository.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];
  final ContactRepository repository = ContactRepository();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final data = await repository.readAllContacts();
    setState(() {
      contacts = data;
    });
  }

  void _addContact(Contact contact) async {
    await repository.create(contact);
    _loadContacts();
  }

  void _editContact(Contact contact, int index) async {
    await repository.update(contact);
    _loadContacts();
  }

  void _deleteContact(int id) async {
    await repository.delete(id);
    _loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: contacts.isEmpty
          ? Center(
              child: Text(
                'Nenhum contato encontrado!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.person, size: 40),
                    title: Text(contact.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16),
                            SizedBox(width: 4),
                            Text(contact.phone),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16),
                            SizedBox(width: 4),
                            Text(contact.email),
                          ],
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactFormScreen(
                                  contact: contact,
                                  onSave: (updatedContact) => _editContact(updatedContact, index),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteContact(contact.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactFormScreen(
                onSave: _addContact,
              ),
            ),
          );
        },
      ),
    );
  }
}
