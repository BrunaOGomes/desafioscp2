class MissionModel {
  final int? id;
  final String name;
  final String launchDate;
  final String status;

  MissionModel({
    this.id,
    required this.name,
    required this.launchDate,
    required this.status,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'],
      name: json['name'],
      launchDate: json['launch_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'launch_date': launchDate,
      'status': status,
    };
  }
}