import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'mission_create_screen.dart';

class MissionListScreen extends StatefulWidget {
  const MissionListScreen({super.key});

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://gdapp.com.br/api/fiap'));
  bool _loading = true;
  String? _error;
  List<dynamic> _missions = [];

  @override
  void initState() {
    super.initState();
    _loadMissions();
  }

  Future<void> _loadMissions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await _dio.get('/missions');
      setState(() => _missions = response.data as List<dynamic>? ?? []);
    } catch (e) {
      setState(() => _error = 'Erro ao carregar missões: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _goToCreate() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const MissionCreateScreen()),
    );
    if (created == true) await _loadMissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AstroLab - Missões')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : RefreshIndicator(
                  onRefresh: _loadMissions,
                  child: ListView.builder(
                    itemCount: _missions.length,
                    itemBuilder: (_, index) {
                      final item = _missions[index] as Map<String, dynamic>;
                      return ListTile(
                        title: Text((item['name'] ?? '').toString()),
                        subtitle: Text(
                          'Lançamento: ${item['launch_date']} · ${item['status']}',
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}
