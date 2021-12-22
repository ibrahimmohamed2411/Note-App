import 'dart:math';

class Note {
  final DateTime timeStamp;
  final String title;
  final bool isImportant;
  final int number;
  final String description;
  Note({
    required this.title,
    required this.timeStamp,
    required this.description,
    required this.isImportant,
    required this.number,
  });
  // Note copy(
  //         {String? id,
  //         String? title,
  //         bool? isImportant,
  //         int? number,
  //         String? description,
  //         DateTime? createdTime}) =>
  //     Note(
  //       timeStamp: id ?? timeStamp,
  //       title: title ?? this.title,
  //       isImportant: isImportant ?? this.isImportant,
  //       number: number ?? this.number,
  //       description: description ?? this.description,
  //       createdTime: createdTime ?? this.createdTime,
  //     );

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      timeStamp: DateTime.parse(json[NoteFields.timeStamp]),
      title: json[NoteFields.title],
      isImportant: json[NoteFields.isImportant] == 1,
      number: json[NoteFields.number],
      description: json[NoteFields.description],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteFields.timeStamp: timeStamp.toIso8601String(),
      NoteFields.title: title,
      NoteFields.isImportant: isImportant ? 1 : 0,
      NoteFields.number: number,
      NoteFields.description: description,
    };
  }
}

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    timeStamp, isImportant, number, title, description,
  ];

  static const String timeStamp = 'timeStamp';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
}
