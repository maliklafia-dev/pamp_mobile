class ReportModel {
  final String id;
  final String groupName;
  final DateTime deliveryDate;

  ReportModel({
    required this.id,
    required this.groupName,
    required this.deliveryDate,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      groupName: json['groupName'],
      deliveryDate: DateTime.parse(json['deliveryDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'deliveryDate': deliveryDate.toIso8601String(),
    };
  }
}
