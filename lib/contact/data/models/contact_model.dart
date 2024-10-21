import 'package:hive/hive.dart';

import '../../domain/entities/contact.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends Contact {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> numbers;

  ContactModel({required this.name, required this.numbers})
      : super(name: name, numbers: numbers);

  // Convert ContactModel to Contact (if needed)
  Contact toEntity() {
    return Contact(name: name, numbers: numbers);
  }

  // Convert Contact to ContactModel
  factory ContactModel.fromEntity(Contact contact) {
    return ContactModel(name: contact.name, numbers: contact.numbers);
  }
}
