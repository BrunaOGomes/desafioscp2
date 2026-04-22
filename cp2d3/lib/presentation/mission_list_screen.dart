import 'package:flutter/material.dart';
import '../di/locator.dart';
import '../viewmodels/mission_viewmodel.dart';
import 'mission_create_screen.dart';

class MissionListScreen extends StatefulWidget {
  const MissionListScreen({super.key});

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
  final viewModel = getIt<MissionViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.loadMissions();
  }

  Future<void> _goToCreate() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const MissionCreateScreen()),
    );

    if (created == true) {
      viewModel.loadMissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orbital Systems - Missões')),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (_, __) {
          if (viewModel.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(child: Text(viewModel.error!));
          }

          return RefreshIndicator(
            onRefresh: viewModel.loadMissions,
            child: ListView.builder(
              itemCount: viewModel.missions.length,
              itemBuilder: (_, index) {
                final mission = viewModel.missions[index];

                return ListTile(
                  title: Text(mission.name),
                  subtitle: Text(
                    'Lançamento: ${mission.launchDate} • ${mission.status}',
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}