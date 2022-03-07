import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/styles.dart';
import 'package:note_app/presentation/routes/app_router.dart';

import '../../../logic/cubits/note/note_cubit.dart';

class NoteDetailsScreen extends StatelessWidget {
  final int noteIndex;
  const NoteDetailsScreen({Key? key, required this.noteIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(builder: (c, state) {
      if (state is NotesLoaded) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<NoteCubit>(context)
                      .shareNote(state.notes[noteIndex]);
                },
                icon: const Icon(Icons.share),
              ),
              IconButton(
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(
                        AppRouter.updateNoteScreen,
                        arguments: state.notes[noteIndex]);
                  },
                  icon: const Icon(Icons.create)),
              IconButton(
                onPressed: () {
                  BlocProvider.of<NoteCubit>(context)
                      .deleteNote(state.notes[noteIndex]);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.notes[noteIndex].title,
                    style: noteTitleStyle,
                  ),
                  Text(
                    DateFormat.yMMMd()
                        .format(state.notes[noteIndex].createdDate),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[350],
                    ),
                  ),
                  Text(
                    state.notes[noteIndex].description,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Text('Error');
    });
  }
}
