import 'package:flutter/material.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/presentation/screens/addNote/add_note_screen.dart';
import 'package:note_app/presentation/screens/homeScreen/home_screen.dart';
import 'package:note_app/presentation/screens/noteDetailsScreen/note_details_screen.dart';
import 'package:note_app/presentation/screens/updateNoteScreen/update_note_screen.dart';

class AppRouter {
  static const String homeScreen = '/';
  static const String addNoteScreen = '/add-note-screen';
  static const String noteDetailsScreen = '/note-details-screen';
  static const String updateNoteScreen = '/update-note-screen';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case addNoteScreen:
        return MaterialPageRoute(builder: (context) => const AddNoteScreen());
      case noteDetailsScreen:
        final note = settings.arguments as Note;
        return MaterialPageRoute(
          builder: (ctx) => NoteDetailsScreen(
            note: note,
          ),
        );
      case updateNoteScreen:
        final note = settings.arguments as Note;
        return MaterialPageRoute(
          builder: (ctx) => UpdateNoteScreen(note: note),
        );
    }
    return null;
  }
}
