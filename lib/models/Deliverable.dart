class Deliverable {
  final String id;
  final String title;
  final DateTime deadline;

  Deliverable({
    required this.id,
    required this.title,
    required this.deadline,
  });

  factory Deliverable.fromJson(Map<String, dynamic> json) {
    return Deliverable(
      id: json['id'] as String,
      title: json['title'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
    );
  }
}