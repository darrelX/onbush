import 'package:dio/dio.dart';
import 'package:onbush/presentation/dashboard/history/data/models/game_history_model.dart';
import 'package:onbush/service_locator.dart';

class GameHistoryRepository {
  final Dio _dio;
  GameHistoryRepository() : _dio = getIt.get<Dio>(instanceName: 'dataApi');

  Future<GameHistoryModels> fetchGameHistory(
      {required String userId, int page = 1}) async {
    try {
      final Response response = await _dio.get('/game-rounds',
          queryParameters: {"user_id": userId, "page": page});

      List<dynamic> data = response.data['data'] as List<dynamic>;
      int total = response.data['total'] as int;
      // print("darrel $total");
      List<GameHistoryModel> gameHistoryList = data
          .map(
              (item) => GameHistoryModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return GameHistoryModels.fromJson(total, gameHistoryList);
    } catch (e) {
      print(e.toString());

      rethrow;
    }
  }
}
