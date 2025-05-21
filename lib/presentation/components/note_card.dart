import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../application/services/note_provider.dart';
import '../../domain/dto/note_dto.dart';
import '../screens/editor.dart';

class NoteCard extends StatelessWidget {
  final QuillController controller;
  final NoteDto note;

  const NoteCard({
    super.key,
    required this.controller,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: 200,
            height: 400,
            child: Card(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  controller.document.toPlainText().toString().length > 50
                      ? '${controller.document.toPlainText().toString().substring(0, 45)}...'
                      : controller.document.toPlainText().toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Editor(
                        note: note,
                        provider:
                            Provider.of<NoteProvider>(context, listen: false),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          note.title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          formatDate(note.date, [MM, ' ', dd, ', ', yyyy]),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
