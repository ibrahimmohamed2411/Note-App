class Note {
  int? id;
  String title;
  String description;
  final DateTime createdDate;
  Note({
    required this.title,
    this.id,
    required this.description,
    required this.createdDate,
  });
  Note copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdDate,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
      );

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json[NoteFields.id],
      title: json[NoteFields.title],
      description: json[NoteFields.description],
      createdDate: DateTime.parse(json[NoteFields.createdDate]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteFields.id: id,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.createdDate: createdDate.toIso8601String(),
    };
  }
}

class NoteFields {
  static final List<String> values = [
    id,
    title,
    description,
    createdDate,
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdDate = 'createdDate';
}
