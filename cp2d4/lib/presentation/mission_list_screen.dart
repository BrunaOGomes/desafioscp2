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
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const MissionCreateScreen()),
    );

    if (created == true) {
      viewModel.loadMissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galaxy Monitor')),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (_, __) {
          switch (viewModel.state) {
            case ViewState.loading:
              return const Center(child: CircularProgressIndicator());

            case ViewState.error:
              return Center(child: Text(viewModel.errorMessage ?? 'Erro'));

            case ViewState.success:
              return RefreshIndicator(
                onRefresh: viewModel.loadMissions,
                child: ListView.builder(
                  itemCount: viewModel.missions.length,
                  itemBuilder: (_, index) {
                    final m = viewModel.missions[index];
                    return ListTile(
                      title: Text(m.name),
                      subtitle: Text(
                        'Lançamento: ${m.launchDate} • ${m.status}',
                      ),
                    );
                  },
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}