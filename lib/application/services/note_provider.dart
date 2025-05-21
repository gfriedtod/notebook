import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:notebook/domain/i_repository/i_repository.dart';

import '../../domain/dto/note_dto.dart';

class NoteProvider with ChangeNotifier implements IRepository {
  final IRepository repositoryImpl;

  NoteProvider(this.repositoryImpl);

  @override
  Future<NoteDto?> createNote(NoteDto note) async {
    try {
      var newNote = await repositoryImpl.createNote(note);
      if (kDebugMode) {
        print(newNote?.toJson());
      }
      notifyListeners();
      print(newNote?.toJson());

      return newNote;
    } catch (e, trace) {
      print(trace);
      // Handle error appropriately
      print('Error adding note: $e');
      return null;
    }
  }

  @override
  deleteNote(String id) async {
    try {
      // _notes.remove(note);
      repositoryImpl.deleteNote(id);
      notifyListeners();
    } catch (e) {
      print('Error removing note: $e');
    }
  }

  @override
  updateNote(NoteDto note) async {
    try {
      print(note.toJson());
      repositoryImpl.updateNote(note);
      notifyListeners();
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<List<NoteDto>> getAllNotes() {
    // TODO: implement getAllNotes
    return repositoryImpl.getAllNotes();
  }
}
