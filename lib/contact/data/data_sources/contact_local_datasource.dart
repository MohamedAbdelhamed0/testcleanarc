import 'package:hive/hive.dart';

import '../models/contact_model.dart';

abstract class ContactLocalDataSource {
  Future<void> addContact(ContactModel contact);
  Future<List<ContactModel>> getContacts();
  Future<void> updateContact(ContactModel contact);
  Future<void> deleteContact(String name);
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  final Box<ContactModel> contactBox;

  ContactLocalDataSourceImpl(this.contactBox);

  @override
  Future<void> addContact(ContactModel contact) async {
    await contactBox.put(contact.name, contact);
  }

  @override
  Future<List<ContactModel>> getContacts() async {
    return contactBox.values.toList();
  }

  @override
  Future<void> updateContact(ContactModel contact) async {
    await contactBox.put(contact.name, contact);
  }

  @override
  Future<void> deleteContact(String name) async {
    await contactBox.delete(name);
  }
}
