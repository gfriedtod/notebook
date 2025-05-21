import 'dart:async';

import 'package:hive_flutter/adapters.dart';
import 'package:notebook/domain/i_repository/i_repository.dart';
import 'package:uuid/uuid.dart';

import '../../domain/dto/note_dto.dart';
import '../../domain/entities/note.dart';

class RepositoryImpl implements IRepository {
  final _notesBox = Hive.box<Note>('notes');

  @override
  Future<NoteDto?> createNote(NoteDto note) async {
    final id = Uuid().v4();
    await _notesBox.put(
        id,
        Note(
            id: id,
            title: note.title,
            content: note.content,
            date: DateTime.now()));
    return getNoteById(id);
  }

  @override
  Future<void> deleteNote(String id) async {
    await _notesBox.delete(id);
  }

  Future<List<Note>> getNotes() async {
    return _notesBox.values.toList();
  }

  @override
  Future<void> updateNote(NoteDto note) async {
    await _notesBox.put(note.id, Note.fromJson(note.toJson()));
  }

  @override
  getAllNotes() async {
    return _notesBox.values
        .map((val) => NoteDto.fromJson(val.toJson()))
        .toList();
  }

  @override
  NoteDto? getNoteById(String id) {
    if (_notesBox.get(id) == null) return null;
    return NoteDto.fromJson(_notesBox.get(id)!.toJson());
  }
}
