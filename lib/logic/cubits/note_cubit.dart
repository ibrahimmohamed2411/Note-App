import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/helpers/database_helper.dart';
import 'package:share/share.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  //dateCreated DataFormat("MMM dd yy HH:mm:ss").format('DateTime.Now')
  //dateEdited DataFormat("MMM dd yy HH:mm:ss").format('DateTime.Now')
  //contentWordCount=wordCount(content)
  NoteCubit() : super(NoteInitial());
  // List<Note> items = [];
  Future<void> getAllNotes() async {
    emit(Loading());
    try {
      List<Note> notes = await DatabaseHelper.instance.readAllNotes();
      for (int i = 0; i < notes.length; i++) {
        print(notes[i].createdTime);
      }
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
        await DatabaseHelper.instance.create(note);
      }
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
  // void shareNote(Note note) {
  //   Share.share("""${note.title}
  //   ${note.content}""");
  // }
}
