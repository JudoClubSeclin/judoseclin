
class Adherents {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String licence;
  final String? belt;
  final String? discipline;
  final String? boardPosition;
  final String? category;
  final String? tutor;
  final String phone;
  final String address;
  final String image;
  final String sante;
  final String medicalCertificate;
  final String invoice;
  final String? familyId;
  final String? additionalAddress;
  final String postalCode;

  Adherents(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.dateOfBirth,
      required this.licence,
      required this.belt,
      required this.discipline,
      required this.boardPosition,
      required this.category,
      this.tutor,
      required this.phone,
      required this.address,
      required this.image,
      required this.sante,
      required this.medicalCertificate,
      required this.invoice,
        required this.postalCode,
      this.familyId,
      this.additionalAddress,

      });



  factory Adherents.fromMap(Map<String, dynamic> data, String id) {
    return Adherents(
        id: id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        dateOfBirth: data['dateOfBirth'] ?? '',
        licence: data['licence'] ?? '',
        belt: data['belt'] ?? '',
        discipline: data['discipline'] ?? '',
        boardPosition: data['boardPosition'] ?? '',
        category: data['category'] ?? '',
        tutor: data['tutor'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
        image: data['image'] ?? '',
        sante: data['sante'] ?? '',
        medicalCertificate: data['medicalCertificate'] ?? '',
        invoice: data['invoice'] ?? '',
        familyId: data['familyId'] ?? '',
        additionalAddress: data['additionalAddress'] ?? '',
        postalCode: data['postalCode'] ?? '',);
  }
}
