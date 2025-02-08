import 'package:onbush/presentation/views/auth/data/models/specialty_model.dart';

abstract class SpecialityRemoteDataSource {
  /// get all availables specialities
  Future<List<SpecialityModel>> getSpecialities();

  /// returns the speciality with the given id
  Future<SpecialityModel> getSpecialityById({required int specialityId});

  /// returns the speciality with the given semester
  Future<SpecialityModel> getSpecialityBySemester({required int semester});

  // /// returns the speciality with the given course id
  // Future<SpecialityModel> get
}