abstract class AdherentsEvent {}

class AddAdherentsSignUpEvent extends AdherentsEvent {
  final String id;
  final String adherentId;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
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
  final bool userExists;
  final String familyId;
  final String additionalAddress;

  AddAdherentsSignUpEvent({
    required this.id,
    required this.adherentId,
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
    required this.userExists,
    required this.familyId,
    required this.additionalAddress
  });
}
class AddCotisationEvent extends AdherentsEvent {
  final String adherentId;
  AddCotisationEvent(this.adherentId) : super();
}

class GeneratePdfEvent extends AdherentsEvent {
  final String adherentId;

  GeneratePdfEvent({required this.adherentId});
}

class CheckFamilyByAddressEvent extends AdherentsEvent {
  final String address;

  CheckFamilyByAddressEvent(this.address);
}

class LoadAllAdherentsEvent extends AdherentsEvent {}

