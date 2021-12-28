import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/data/repositories/note_repository.dart';
import 'package:note_app/data/services/local/database_helper.dart';
import 'package:share/share.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  final NoteRepository _noteRepository = NoteRepository();
  Future<void> getAllNotes() async {
    emit(Loading());
    try {
      List<Note> notes = await _noteRepository.readAllNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> addNote(Note note) async {
    try {
      if (state is NotesLoaded) {
        final updatedNote = (state as NotesLoaded).notes;
        updatedNote.add(note);
        emit(NotesLoaded(notes: updatedNote));
        await _noteRepository.create(note);
      }
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> deleteNote(Note note) async {
    if (state is NotesLoaded) {
      final updatedNote = (state as NotesLoaded).notes;
      updatedNote.remove(note);
      emit(NotesLoaded(notes: updatedNote));
      await DatabaseHelper.instance.delete(note.timeStamp.toIso8601String());
    }
  }

  // void shareNote(Note note) {
  //   Share.share("""${note.title}
  //   ${note.content}""");
  // }
}
