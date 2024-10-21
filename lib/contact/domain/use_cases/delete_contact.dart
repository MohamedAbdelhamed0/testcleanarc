import '../repositories/contact_repository.dart';

class DeleteContact {
  final ContactRepository repository;

  DeleteContact(this.repository);

  Future<void> call(String name) async {
    return await repository.deleteContact(name);
  }
}
