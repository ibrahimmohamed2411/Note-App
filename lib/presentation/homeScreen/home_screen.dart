import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';
import 'package:note_app/data/services/local/database_helper.dart';
import 'package:note_app/presentation/homeScreen/widgets/note_list_widget.dart';
import 'package:note_app/presentation/routes/app_router.dart';
import 'package:note_app/presentation/homeScreen/widgets/empty_list_widget.dart';
import 'package:note_app/presentation/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
    DatabaseHelper.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
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
