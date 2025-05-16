class DeliverableModel {
  final String id;
  final String groupName;
  final DateTime deliveryDate;
  final bool isDelivered;
  final int compliance;
  final int similarity;

  DeliverableModel({
    required this.id,
    required this.groupName,
    required this.deliveryDate,
    this.isDelivered = true,
    required this.compliance,
    required this.similarity,
  });

  factory DeliverableModel.fromJson(Map<String, dynamic> json) {
    return DeliverableModel(
      id: json['id'],
      groupName: json['groupName'],
      deliveryDate: DateTime.parse(json['deliveryDate']),
      isDelivered: json['isDelivered'] ?? true,
      compliance: json['compliance'],
      similarity: json['similarity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'deliveryDate': deliveryDate.toIso8601String(),
      'isDelivered': isDelivered,
      'compliance': compliance,
      'similarity': similarity,
    };
  }
}
