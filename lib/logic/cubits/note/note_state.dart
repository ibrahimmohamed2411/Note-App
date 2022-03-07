part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class Loading extends NoteState {}

class Error extends NoteState {
  final String error;
  Error({required this.error});
}

class NotesLoaded extends NoteState {
  final List<Note> notes;
  NotesLoaded({required this.notes});
  List<Object> get props => [notes];

  NotesLoaded copyWith({
    required List<Note> items,
  }) {
    return NotesLoaded(
      notes: items,
    );
  }
}
