import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'contact/data/data_sources/contact_local_datasource.dart';
import 'contact/data/models/contact_model.dart';
import 'contact/data/repositories/contact_repository_impl.dart';
import 'contact/domain/use_cases/add_contact.dart';
import 'contact/domain/use_cases/delete_contact.dart';
import 'contact/domain/use_cases/get_contacts.dart';
import 'contact/domain/use_cases/update_contact.dart';
import 'contact/presentation/manager/contact_cubit.dart';
import 'contact/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  final contactBox = await Hive.openBox<ContactModel>('contacts');

  // Data Layer
  final localDataSource = ContactLocalDataSourceImpl(contactBox);
  final repository = ContactRepositoryImpl(localDataSource);

  // Domain Layer
  final addContact = AddContact(repository);
  final getContacts = GetContacts(repository);
  final updateContact = UpdateContact(repository);
  final deleteContact = DeleteContact(repository);

  runApp(MyApp(
    addContact: addContact,
    getContacts: getContacts,
    updateContact: updateContact,
    deleteContact: deleteContact,
  ));
}

class MyApp extends StatelessWidget {
  final AddContact addContact;
  final GetContacts getContacts;
  final UpdateContact updateContact;
  final DeleteContact deleteContact;

  const MyApp({
    super.key,
    required this.addContact,
    required this.getContacts,
    required this.updateContact,
    required this.deleteContact,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactCubit(
        addContactUseCase: addContact,
        getContactsUseCase: getContacts,
        updateContactUseCase: updateContact,
        deleteContactUseCase: deleteContact,
      )..loadContacts(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
