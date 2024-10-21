import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class UpdateContact {
  final ContactRepository repository;

  UpdateContact(this.repository);

  Future<void> call(Contact contact) async {
    return await repository.updateContact(contact);
  }
}
