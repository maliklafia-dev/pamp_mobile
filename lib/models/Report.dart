class Report {
  final String id;
  final String title;
  final String content;

  Report({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}