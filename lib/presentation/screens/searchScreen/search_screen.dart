import 'package:flutter/material.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/presentation/screens/homeScreen/widgets/note_list_widget.dart';

class Search extends SearchDelegate {
  List<Note> data;
  Search({required this.data});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Note> notes = [];
    for (Note note in data) {
      if (note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.description.toLowerCase().contains(query.toLowerCase())) {
        notes.add(note);
      }
    }
    if (notes.isNotEmpty) {
      return NoteListWidget(
        notes: notes,
      );
    }
    return const Center(child: Text('No result found'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
