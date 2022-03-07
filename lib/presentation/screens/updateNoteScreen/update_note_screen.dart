import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/styles.dart';
import 'package:note_app/data/models/note.dart';

import '../../../logic/cubits/note/note_cubit.dart';

class UpdateNoteScreen extends StatelessWidget {
  final Note note;
  UpdateNoteScreen({Key? key, required this.note}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController =
        TextEditingController(text: note.title);
    TextEditingController _descriptionController =
        TextEditingController(text: note.description);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<NoteCubit>(context).replaceNote(
                  note,
                  note.copy(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                cursorColor: Colors.green,
                keyboardType: TextInputType.text,
                maxLength: 30,
                style: noteTitleStyle,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                validator: (title) {
                  if (title!.isEmpty) {
                    return 'Please enter the title for your note';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                cursorColor: Colors.green,
                maxLines: 60,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  hintText: 'Type something....',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                validator: (description) {
                  if (description!.isEmpty) {
                    return 'Please enter the description for your note';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
