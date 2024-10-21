import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class GetContacts {
  final ContactRepository repository;

  GetContacts(this.repository);

  Future<List<Contact>> call() async {
    return await repository.getContacts();
  }
}
