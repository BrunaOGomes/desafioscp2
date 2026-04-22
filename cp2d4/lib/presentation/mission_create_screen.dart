import 'package:flutter/material.dart';
import '../di/locator.dart';
import '../models/mission_model.dart';
import '../viewmodels/mission_viewmodel.dart';

class MissionCreateScreen extends StatefulWidget {
  const MissionCreateScreen({super.key});

  @override
  State<MissionCreateScreen> createState() => _MissionCreateScreenState();
}

class _MissionCreateScreenState extends State<MissionCreateScreen> {
  final viewModel = getIt<MissionViewModel>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _launchDateController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _launchDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final mission = MissionModel(
      name: _nameController.text,
      launchDate: _launchDateController.text,
      status: _statusController.text,
    );

    final success = await viewModel.createMission(mission);

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage ?? 'Erro')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Missão')),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (_, __) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome'),
                      ),
                      TextFormField(
                        controller: _launchDateController,
                        decoration: const InputDecoration(
                            labelText: 'Data (YYYY-MM-DD)'),
                      ),
                      TextFormField(
                        controller: _statusController,
                        decoration: const InputDecoration(labelText: 'Status'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Cadastrar'),
                      ),
                    ],
                  ),
                ),
              ),
              if (viewModel.state == ViewState.loading)
                const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}