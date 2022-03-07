import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:share/share.dart';

import '../../../data/models/note.dart';
import '../../../data/repositories/note_repository.dart';
import '../../../data/services/local/database_helper.dart';

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
        final id = await _noteRepository.create(note);
        final newNote = note.copy(id: id);
        final updatedNotes = List<Note>.from((state as NotesLoaded).notes)
          ..add(newNote);
        emit(NotesLoaded(notes: updatedNotes));
      }
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> deleteNote(Note note) async {
    if (state is NotesLoaded) {
      try {
        final updatedNote = List<Note>.from((state as NotesLoaded).notes);
        updatedNote.remove(note);
        emit(NotesLoaded(notes: updatedNote));
        await DatabaseHelper.instance.delete(note.id!);
      } catch (e) {
        emit(Error(error: e.toString()));
      }
    }
  }

  Future<void> replaceNote(Note oldNote, Note newNote) async {
    try {
      if (state is NotesLoaded) {
        final notes = List<Note>.from((state as NotesLoaded).notes);
        final int index = notes.indexOf(oldNote);
        notes[index] = newNote;
        emit(NotesLoaded(notes: notes));
        await _noteRepository.update(newNote);
      }
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }

  Future<void> shareNote(Note note) async {
    await Share.share("""${note.title}
    ${note.description}""");
  }

  Future<int> deleteAllNotes() async {
    if (state is NotesLoaded) {
      List<Note>.from((state as NotesLoaded).notes).clear();
      emit(NotesLoaded(notes: const []));
      return await _noteRepository.deleteAllNotes();
    }
    return -1;
  }
}
