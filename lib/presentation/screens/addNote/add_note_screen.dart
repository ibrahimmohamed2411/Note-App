import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/constants/styles.dart';
import 'package:note_app/data/models/note.dart';

import '../../../logic/cubits/note/note_cubit.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<NoteCubit>(context).addNote(
                  Note(
                    title: titleController.text,
                    description: descriptionController.text,
                    createdDate: DateTime.now(),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  cursorColor: Colors.green,
                  controller: titleController,
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
                  controller: descriptionController,
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
                    // fillColor: Colors.grey,
                    // filled: true,
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
      ),
    );
  }
}
