import 'package:dio/dio.dart';
import '../models/mission_model.dart';

class MissionService {
  final Dio dio;

  MissionService(this.dio);

  Future<List<MissionModel>> getMissions() async {
    final response = await dio.get('/missions');

    return (response.data as List)
        .map((e) => MissionModel.fromJson(e))
        .toList();
  }

  Future<void> createMission(MissionModel mission) async {
    await dio.post('/missions', data: mission.toJson());
  }
}