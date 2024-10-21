import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../data_sources/contact_local_datasource.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource localDataSource;

  ContactRepositoryImpl(this.localDataSource);

  @override
  Future<void> addContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    await localDataSource.addContact(contactModel);
  }

  @override
  Future<List<Contact>> getContacts() async {
    final models = await localDataSource.getContacts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateContact(Contact contact) async {
    final contactModel = ContactModel.fromEntity(contact);
    await localDataSource.updateContact(contactModel);
  }

  @override
  Future<void> deleteContact(String name) async {
    await localDataSource.deleteContact(name);
  }
}
