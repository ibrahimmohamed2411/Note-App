import 'package:flutter/material.dart';

Future<void> customAlertDialog(
    {required BuildContext context,
    VoidCallback? btnOk,
    required String content}) async {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text('Confirm Delete'),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: btnOk,
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
