import 'package:flutter/material.dart';
import '../models/mission_model.dart';
import '../services/mission_service.dart';

enum ViewState { idle, loading, success, error }

class MissionViewModel extends ChangeNotifier {
  final MissionService service;

  MissionViewModel(this.service);

  List<MissionModel> missions = [];
  ViewState state = ViewState.idle;
  String? errorMessage;

  Future<void> loadMissions() async {
    state = ViewState.loading;
    notifyListeners();

    try {
      missions = await service.getMissions();
      state = ViewState.success;
    } catch (e) {
      errorMessage = 'Erro ao carregar missões';
      state = ViewState.error;
    }

    notifyListeners();
  }

  Future<bool> createMission(MissionModel mission) async {
    state = ViewState.loading;
    notifyListeners();

    try {
      await service.createMission(mission);
      state = ViewState.success;
      return true;
    } catch (e) {
      errorMessage = 'Erro ao cadastrar missão';
      state = ViewState.error;
      return false;
    } finally {
      notifyListeners();
    }
  }
}