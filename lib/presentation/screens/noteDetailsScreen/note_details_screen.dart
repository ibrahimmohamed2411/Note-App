import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants/styles.dart';
import 'package:note_app/presentation/routes/app_router.dart';

import '../../../data/models/note.dart';
import '../../../logic/cubits/note/note_cubit.dart';
import '../../widgets/custom_alert_dialog.dart';

class NoteDetailsScreen extends StatefulWidget {
  Note note;
  NoteDetailsScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<NoteCubit>(context).shareNote(widget.note);
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(AppRouter.updateNoteScreen,
                        arguments: widget.note)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      widget.note = value as Note;
                    });
                  }
                });
              },
              icon: const Icon(Icons.create)),
          IconButton(
            onPressed: () {
              customAlertDialog(
                context: context,
                btnOk: () {
                  BlocProvider.of<NoteCubit>(context).deleteNote(widget.note);
                  Navigator.of(context).pop(); //close the dialog
                  Navigator.of(context).pop(); //step back
                },
                content: 'Delete this note ?',
              );
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
                widget.note.title,
                style: noteTitleStyle,
              ),
              Text(
                DateFormat.yMMMd().format(widget.note.createdDate),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[350],
                ),
              ),
              Text(
                widget.note.description,
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
