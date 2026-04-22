import 'package:flutter/material.dart';
import '../models/mission_model.dart';
import '../services/mission_service.dart';

class MissionViewModel extends ChangeNotifier {
  final MissionService service;

  MissionViewModel(this.service);

  List<MissionModel> missions = [];
  bool loading = false;
  String? error;

  Future<void> loadMissions() async {
    loading = true;
    notifyListeners();

    try {
      missions = await service.getMissions();
      error = null;
    } catch (e) {
      error = 'Erro ao carregar missões';
    }

    loading = false;
    notifyListeners();
  }

  Future<bool> createMission(MissionModel mission) async {
    try {
      await service.createMission(mission);
      return true;
    } catch (e) {
      return false;
    }
  }
}