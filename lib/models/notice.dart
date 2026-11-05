class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.department,
    required this.category,
    required this.description,
    required this.createdAt,
    this.important = false,
  });

  final String id;
  final String title;
  final String department;
  final String category;
  final String description;
  final DateTime createdAt;
  final bool important;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'department': department,
        'category': category,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'important': important,
      };

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        id: json['id'] as String,
        title: json['title'] as String,
        department: json['department'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        important: json['important'] as bool? ?? false,
      );
}
