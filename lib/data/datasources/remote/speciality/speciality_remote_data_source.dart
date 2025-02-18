import 'package:onbush/data/models/speciality/speciality_model.dart';


abstract class SpecialityRemoteDataSource {
  /// get all availables specialities
  Future<List<SpecialityModel>> getAllSpecialities(int schoolId);



  /// returns the speciality with the given id
  Future<SpecialityModel> getSpecialityById({required int specialityId});


  // /// returns the speciality with the given course id
  // Future<SpecialityModel> get
}