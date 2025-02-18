
import 'package:onbush/data/models/mentee/mentee_model.dart';

abstract class MenteeRemoteDataSource {
  const MenteeRemoteDataSource();

  /// get all availables mentees
  Future<List<MenteeModel>> getAllMentees({required String device, required String email});
}
