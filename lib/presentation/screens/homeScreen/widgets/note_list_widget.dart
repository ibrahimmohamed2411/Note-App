import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/presentation/widgets/note_card.dart';

class NoteListWidget extends StatelessWidget {
  final List<Note> notes;
  const NoteListWidget({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: notes.length,
      itemBuilder: (ctx, index) => NoteCardWidget(
        note: notes[index],
        index: index,
      ),
    );
  }
}
