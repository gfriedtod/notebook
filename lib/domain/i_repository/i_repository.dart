import 'package:notebook/domain/dto/note_dto.dart';

abstract class IRepository {
  Future<NoteDto?> createNote(NoteDto note);

  Future<List<NoteDto>> getAllNotes();

  Future<void> updateNote(NoteDto note);

  Future<void> deleteNote(String id);
}
