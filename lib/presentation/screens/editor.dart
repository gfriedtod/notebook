import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../application/services/note_provider.dart';
import '../../domain/dto/note_dto.dart';

class Editor extends StatefulWidget {
  final NoteDto note;
  final NoteProvider? provider;

  Editor({super.key, required this.note, this.provider});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    _controller.document = Document.fromJson(jsonDecode(widget.note.content));
    print(_controller.document.toDelta().toJson());

    _controller.addListener(() {
      print(_controller.document.toDelta().toJson());

      var contentJs = _controller.document.toDelta().toJson();
      var content = jsonEncode(contentJs);
      widget.provider?.updateNote(widget.note.copyWith(content: (content)));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.note.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(),
          ),
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              config: const QuillEditorConfig(),
            ),
          ),
        ],
      ),
    );
  }
}
