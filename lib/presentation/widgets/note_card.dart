import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/logic/cubits/note_cubit.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    // var time = DateFormat("dd MMM yy hh:mm").format(note.timeStamp);
    final time = DateFormat.yMMMd().format(note.timeStamp);
    final minHeight = getMinHeight(index);

    return InkWell(
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
                  BlocProvider.of<NoteCubit>(context).deleteNote(note);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        );
      },
      child: Card(
        color: color,
        child: Container(
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 4),
              Text(
                note.title.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                note.description,
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
