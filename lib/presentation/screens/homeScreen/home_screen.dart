import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';
import 'package:note_app/data/services/local/database_helper.dart';
import 'package:note_app/presentation/routes/app_router.dart';
import 'package:note_app/presentation/screens/homeScreen/widgets/empty_list_widget.dart';
import 'package:note_app/presentation/screens/homeScreen/widgets/note_list_widget.dart';
import 'package:note_app/presentation/widgets/custom_alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
    // DatabaseHelper.instance.close();
  }

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
                  content: 'You will delete all your Notes!!!');
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
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
            return NoteListWidget(notes: state.notes);
          }
          if (state is Error) {
            return Center(child: Text(state.error.toString()));
          }
          return const Center(child: Text('Error'));
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
