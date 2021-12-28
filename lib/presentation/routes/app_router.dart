import 'package:flutter/material.dart';
import 'package:note_app/presentation/addNote/add_note_screen.dart';
import 'package:note_app/presentation/homeScreen/home_screen.dart';

class AppRouter {
  static const String homeScreen = '/';
  static const String addNoteScreen = '/add-note-screen';
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case addNoteScreen:
        return MaterialPageRoute(builder: (context) => const AddNoteScreen());
    }
  }
}
