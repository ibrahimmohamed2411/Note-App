import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              //
              // }
              BlocProvider.of<NoteCubit>(context).addNote(
                Note(
                  title: 'title',
                  description: 'description',
                  createdTime: DateTime.now(),
                  isImportant: true,
                  number: 2,
                ),
              );
              Navigator.of(context).pop();
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
                  keyboardType: TextInputType.text,
                  maxLength: 30,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
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
                    if (title == null) {
                      return 'Please enter the title for your note';
                    }
                    return null;
                  },
                ),
                TextFormField(
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
                    if (description == null) {
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
