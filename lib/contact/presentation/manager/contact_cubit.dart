import 'package:bloc/bloc.dart';

import '../../domain/entities/contact.dart';
import '../../domain/use_cases/add_contact.dart';
import '../../domain/use_cases/delete_contact.dart';
import '../../domain/use_cases/get_contacts.dart';
import '../../domain/use_cases/update_contact.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final AddContact addContactUseCase;
  final GetContacts getContactsUseCase;
  final UpdateContact updateContactUseCase;
  final DeleteContact deleteContactUseCase;

  ContactCubit({
    required this.addContactUseCase,
    required this.getContactsUseCase,
    required this.updateContactUseCase,
    required this.deleteContactUseCase,
  }) : super(ContactInitial());

  Future<void> loadContacts() async {
    emit(ContactLoading());
    final contacts = await getContactsUseCase();
    emit(ContactLoaded(contacts));
  }

  Future<void> createContact(Contact contact) async {
    await addContactUseCase(contact);
    await loadContacts();
  }

  Future<void> modifyContact(Contact contact) async {
    await updateContactUseCase(contact);
    await loadContacts();
  }

  Future<void> removeContact(String name) async {
    await deleteContactUseCase(name);
    await loadContacts();
  }
}
