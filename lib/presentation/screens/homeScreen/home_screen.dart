import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/presentation/screens/homeScreen/widgets/empty_list_widget.dart';
import 'package:note_app/presentation/screens/homeScreen/widgets/note_list_widget.dart';
import 'package:note_app/presentation/widgets/custom_alert_dialog.dart';

import '../../../logic/cubits/note/note_cubit.dart';
import '../../routes/app_router.dart';
import '../searchScreen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              customAlertDialog(
                context: context,
                btnOk: () {
                  BlocProvider.of<NoteCubit>(context).deleteAllNotes();
                  Navigator.of(context).pop();
                },
                content: 'You will delete all your Notes!!!',
              );
            },
            icon: const Icon(Icons.delete),
          ),
          BlocBuilder<NoteCubit, NoteState>(
            buildWhen: (pre, current) => pre != current,
            builder: (context, state) {
              if (state is NotesLoaded) {
                return IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: Search(
                      data: state.notes,
                    ),
                  ),
                  icon: const Icon(Icons.search),
                );
              }
              return const IconButton(
                onPressed: null,
                icon: Icon(Icons.search),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (ctx, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return const EmptyListWidget();
            }
            return NoteListWidget(
              notes: state.notes,
              beforeTap: () {},
            );
          }
          if (state is Error) {
            return Center(child: Text(state.error.toString()));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.addNoteScreen);
        },
      ),
    );
  }
}
