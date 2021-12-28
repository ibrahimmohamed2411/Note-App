import 'package:flutter/foundation.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/data/services/local/database_helper.dart';

class NoteRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  Future<int> create(Note note) async {
    final id = await _databaseHelper.create(note.toJson());
    return id;
  }

  Future<List<Note>> readAllNotes() async {
    final List<Map<String, dynamic>> result =
        await _databaseHelper.readAllNotes();
    return compute(parseNotes, result);
  }

  Future<int> delete(String timeStamp) async {
    return _databaseHelper.delete(timeStamp);
  }

  Future<int> deleteAllNotes() async {
    return _databaseHelper.deleteAllNotes();
  }

  Future<int> update(Note note) async {
    return await _databaseHelper.update(note);
  }
}

List<Note> parseNotes(List<Map<String, dynamic>> json) {
  return json.map((json) => Note.fromJson(json)).toList();
}
