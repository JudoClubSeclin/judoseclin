import 'package:intl/intl.dart';
import 'package:judoseclin/core/utils/date_converter.dart';

class Users {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String email;
  final String password;

  Users(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      required this.email,
      required this.password});

  String get formattedDateOfBirth {
    return DateFormat('dd/MM/yyyy').format(dateOfBirth!);
  }

  factory Users.fromMap(Map<String, dynamic> data, String id) {
    return Users(
      id: id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      dateOfBirth: DateConverter.convertToDateTime(data['dateOfBirth']),
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
