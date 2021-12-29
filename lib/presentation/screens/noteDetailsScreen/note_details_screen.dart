import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/styles.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';
import 'package:note_app/presentation/routes/app_router.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;
  const NoteDetailsScreen({Key? key, required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<NoteCubit>(context).shareNote(note);
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(AppRouter.updateNoteScreen, arguments: note);
              },
              icon: const Icon(Icons.create)),
          IconButton(
            onPressed: () {
              BlocProvider.of<NoteCubit>(context).deleteNote(note);
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
                note.title,
                style: noteTitleStyle,
              ),
              Text(
                DateFormat.yMMMd().format(note.createdDate),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[350],
                ),
              ),
              Text(
                note.description,
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
}
