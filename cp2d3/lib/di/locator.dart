import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../services/mission_service.dart';
import '../viewmodels/mission_viewmodel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'https://gdapp.com.br/api/fiap')),
  );

  getIt.registerLazySingleton<MissionService>(
    () => MissionService(getIt()),
  );

  getIt.registerFactory<MissionViewModel>(
    () => MissionViewModel(getIt()),
  );
}