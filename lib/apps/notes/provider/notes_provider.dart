import 'package:flutter/foundation.dart';

import 'package:extra/apps/notes/models/notes_data.dart';
import 'package:extra/apps/notes/helper/note_db.dart';

class Notes with ChangeNotifier {
  List<Note> _notesItem = [];

  List<Note> get items {
    return [..._notesItem];
  }

  Note findById(String id) {
    return _notesItem.firstWhere((note) => note.id == id);
  }

  Future<void> addNote(
    String inputTitle,
    String inputText,
  ) async {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: inputTitle,
      text: inputText,
    );
    _notesItem.add(newNote);

    DBHelper.insert(
      'user_notes',
      {
        'id': newNote.id,
        'title': newNote.title,
        'text': newNote.text,
      },
    );
    notifyListeners();
  }

  Future<void> updateNote(
    String inputTitle,
    String inputText,
    String id,
  ) async {
    final newNote = Note(
      id: id,
      title: inputTitle,
      text: inputText,
    );

    final noteIndex = _notesItem.indexWhere((item) => item.id == id);
    if (noteIndex >= 0) {
      _notesItem[noteIndex] = newNote;
      notifyListeners();
    }
    DBHelper.update(
      'user_notes',
      Note(
        id: id,
        title: inputTitle,
        text: inputText,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _notesItem.removeWhere((item) => item.id == id);
    notifyListeners();
    await DBHelper.delete(
      'user_notes',
      id,
    );
    notifyListeners();
  }

  Future<void> fetchAndSetNotes() async {
    final dataList = await DBHelper.getData('user_notes');
    _notesItem = dataList
        .map(
          (item) => Note(
            id: item['id'],
            title: item['title'],
            text: item['text'],
          ),
        )
        .toList();
    notifyListeners();
  }

  void addedData() {
    DBHelper.totalData++;
    notifyListeners();
  }

  void removedData() {
    DBHelper.totalData--;
    notifyListeners();
  }
}
