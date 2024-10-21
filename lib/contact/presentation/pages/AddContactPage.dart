import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
;
import '../../domain/entities/contact.dart';
import '../manager/contact_cubit.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  AddContactPageState createState() => AddContactPageState();
}

class AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  List<String> _numbers = [''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Input
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value?.trim() ?? '';
                },
                validator: (value) {
                  return (value == null || value.trim().isEmpty)
                      ? 'Please enter a name'
                      : null;
                },
              ),
              const SizedBox(height: 16),
              // Phone Numbers Input
              Expanded(
                child: ListView.builder(
                  itemCount: _numbers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number ${index + 1}',
                            ),
                            onSaved: (value) {
                              _numbers[index] = value?.trim() ?? '';
                            },
                            validator: (value) {
                              return (value == null || value.trim().isEmpty)
                                  ? 'Please enter a phone number'
                                  : null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              if (_numbers.length > 1) {
                                _numbers.removeAt(index);
                              } else {
                                _numbers[index] = '';
                              }
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Add Number Button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _numbers.add('');
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Phone Number'),
                ),
              ),
              const SizedBox(height: 16),
              // Save Button
              ElevatedButton(
                onPressed: _saveContact,
                child: const Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveContact() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Remove empty numbers
      _numbers = _numbers.where((number) => number.isNotEmpty).toList();
      // Create Contact object
      final newContact = Contact(name: _name, numbers: _numbers);
      // Add contact using Cubit
      context.read<ContactCubit>().createContact(newContact);
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }
}
