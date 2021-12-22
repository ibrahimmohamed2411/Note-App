import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';
import 'package:note_app/logic/helpers/database_helper.dart';
import 'package:note_app/presentation/addNote/add_note_screen.dart';
import 'package:note_app/presentation/routes/app_router.dart';
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
      body: BlocBuilder<NoteCubit, NoteState>(builder: (ctx, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is NotesLoaded) {
          if (state.notes.isEmpty) {
            return emptyList();
          }
          return buildNotes(state.notes);
        }
        if (state is Error) {
          // return Center(child: Text(state.error.toString()));
          throw Exception(state.error);
        }
        return const Center(child: Text('Error'));
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRouter.addNoteScreen);
        },
      ),
    );
  }

  Widget emptyList() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no_notes.png'),
          const Text(
            'You don\'t have any notes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  Widget buildNotes(List<Note> notes) => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemCount: notes.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () {
            //go to details screen
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Confirm Delete'),
                actions: [
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<NoteCubit>(context)
                          .deleteNote(notes[index]);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
          },
          child: NoteCardWidget(
            note: notes[index],
            index: index,
          ),
        ),
      );
}
