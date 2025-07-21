class AdherentsInfoDto {
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

  AdherentsInfoDto({
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
    required this.familyId
  });


  factory AdherentsInfoDto.fromJson(Map<String, dynamic> json) {
    return AdherentsInfoDto(
        id: json['id'],
        firstName:json ['firstName'],
        lastName: json ['lastName'],
        email: json ['email'],
        dateOfBirth:json ['dateOfBirth'],
        licence: json ['licence'],
        belt: json ['belt'],
        discipline: json ['discipline'],
        category: json ['category'],
        tutor: json ['tutor'],
        phone: json ['phone'],
        address: json ['address'],
        image: json ['image'],
        sante: json ['sante'],
        medicalCertificate: json ['medicalCertificate'],
        invoice: json ['invoice'],
        familyId: json ['familyId']
    );
  }
}
