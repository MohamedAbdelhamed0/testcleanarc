import '../entities/contact.dart';

abstract class ContactRepository {
  Future<void> addContact(Contact contact);
  Future<List<Contact>> getContacts();
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(String name);
}
