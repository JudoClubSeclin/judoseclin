

class Users {
  final String id;
  final String email;
  final String password;

  Users(
      {required this.id,

      required this.email,
      required this.password});



  factory Users.fromMap(Map<String, dynamic> data, String id) {
    return Users(
      id: id,
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
