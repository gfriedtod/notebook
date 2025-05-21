import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notebook/application/services/note_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/dto/note_dto.dart';
import '../../utils/utils.dart';
import '../components/note_card.dart';
import 'editor.dart';

class ListOfNotes extends StatelessWidget {
  const ListOfNotes({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF6256EF),
        onPressed: () {
          final title = TextEditingController();
          final nProvider = Provider.of<NoteProvider>(context, listen: false);
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Add Note'),
                    content: TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                          hintText: 'Enter note title',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Add'),
                        onPressed: () async {
                          if (title.text.trim().isEmpty) {
                            return;
                          }

                          final note = NoteDto(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(), // Simple unique ID
                            title: title.text.trim(),
                            content: DEFAULT_CONTENT,
                            date: DateTime.now(),
                          );

                          try {
                            if (!context.mounted) return;

                            nProvider.createNote(note).then((note) {
                              print('note: $note');
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => Editor(
                                    note: note!,
                                    provider: nProvider,
                                  ),
                                ),
                              );
                            });
                          } catch (e) {
                            print(e);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to create note: ${e.toString()}')),
                            );
                          }
                        },
                      ),
                    ]);
              });
        },
        label: Text(
          'Add Note',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
          child: FutureBuilder<List<NoteDto>>(
        future: Provider.of<NoteProvider>(context).getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/empty.png'),
                    SizedBox(
                      height: 10,
                    ),
                    const Text('No notes available',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            );
          }

          return SizedBox(
            height: size.height * 0.9,
            width: size.width * 0.9,
            child: GridView.builder(
              addRepaintBoundaries: false,
              shrinkWrap: true,
              // padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                QuillController controller = QuillController.basic();

                final note = snapshot.data![index];
                controller.document =
                    Document.fromJson(jsonDecode(note.content));

                return Dismissible(
                    onDismissed: (direction) {
                      Provider.of<NoteProvider>(context, listen: false)
                          .deleteNote(note.id);
                    },
                    background: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.centerRight,
                        child: Center(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    key: Key(note.id),
                    child: NoteCard(controller: controller, note: note));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          );
        },
      )),
    );
  }
}
