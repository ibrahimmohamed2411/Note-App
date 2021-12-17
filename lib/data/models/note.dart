class Note {
  final int? id;
  final String title;
  final bool isImportant;
  final int number;
  final String description;
  final DateTime createdTime;
  Note({
    required this.title,
    this.id,
    required this.description,
    required this.createdTime,
    required this.isImportant,
    required this.number,
  });
  Note copy(
          {int? id,
          String? title,
          bool? isImportant,
          int? number,
          String? content,
          DateTime? createdTime}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        description: content ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: int.parse(json["id"]),
      isImportant: int.parse(json["isImportant"]) == 1,
      number: int.parse(json["number"]),
      title: json["title"],
      description: json["description"],
      createdTime: DateTime.parse(json["createdTime"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteFields.id: id,
      NoteFields.isImportant: isImportant ? 1 : 0,
      NoteFields.number: number,
      NoteFields.title: title,
      NoteFields.description: description,
      NoteFields.createdTime: createdTime.toIso8601String(),
    };
  }

//

}

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, createdTime
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdTime = 'createdTime';
}
