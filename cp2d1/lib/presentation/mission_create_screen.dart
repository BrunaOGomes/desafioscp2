import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MissionCreateScreen extends StatefulWidget {
  const MissionCreateScreen({super.key});

  @override
  State<MissionCreateScreen> createState() => _MissionCreateScreenState();
}

class _MissionCreateScreenState extends State<MissionCreateScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://gdapp.com.br/api/fiap'));
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _launchDateController = TextEditingController();
  final _statusController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _launchDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await _dio.post(
        '/missions',
        data: {
          'name': _nameController.text.trim(),
          'launch_date': _launchDateController.text.trim(),
          'status': _statusController.text.trim(),
        },
      );

      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao cadastrar missão.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Missão')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe o nome.' : null,
              ),
              TextFormField(
                controller: _launchDateController,
                decoration: const InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe a data.' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe o status.' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
