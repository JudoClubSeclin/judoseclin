class AdherentsDto {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime dateOfBirth;
  final String licence;
  final String belt;
  final String discipline;
  final String category;
  final String tutor;
  final String phone;
  final String address;
  final String image;
  final String sante;
  final String medicalCertificate;
  final String invoice;
  final String familyId;
  final String additionalAddress;

  AdherentsDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.licence,
    required this.belt,
    required this.discipline,
    required this.category,
    required this.tutor,
    required this.phone,
    required this.address,
    required this.image,
    required this.sante,
    required this.medicalCertificate,
    required this.invoice,
    required this.familyId,
    required this.additionalAddress
  });
}
