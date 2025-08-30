class UserInfoDto {
  final bool isAdministrator;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String? licenseNumber;

  UserInfoDto({
    required this.isAdministrator,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.licenseNumber,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return UserInfoDto(
      isAdministrator: json['isAdministrator'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      licenseNumber: json['licence'],
    );
  }
}
