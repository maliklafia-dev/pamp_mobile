class Criterion {
  final String id;
  final String name;
  final int maxScore;
  int score;

  Criterion({
    required this.id,
    required this.name,
    required this.maxScore,
    this.score = 0,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) {
    return Criterion(
      id: json['id'] as String,
      name: json['name'] as String,
      maxScore: json['maxScore'] as int,
      score: json['score'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'maxScore': maxScore,
    'score': score,
  };
}

class Rubric {
  final String id;
  final String title;
  final List<Criterion> criteria;

  Rubric({
    required this.id,
    required this.title,
    required this.criteria,
  });

  factory Rubric.fromJson(Map<String, dynamic> json) {
    return Rubric(
      id: json['id'] as String,
      title: json['title'] as String,
      criteria: (json['criteria'] as List)
          .map((e) => Criterion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}