import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:extra/apps/notes/models/notes_data.dart';
import 'package:extra/apps/notes/provider/notes_provider.dart';
import 'package:extra/theme/theme.dart';
import 'package:extra/screens/note.dart';

class AddNotes extends StatefulWidget {
  static const routeName = '/add-notes';

  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  var selectedNote = Note(
    id: '',
    title: '',
    text: '',
  );

  var _isInit = true;

  late CustomArgument args;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      args = ModalRoute.of(context)!.settings.arguments as CustomArgument;
    }
    if (args.eMode == EditingMode.editing) {
      selectedNote =
          Provider.of<Notes>(context, listen: false).findById(args.id);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (args.eMode == EditingMode.editing) {
      _titleController.text = selectedNote.title.trim();
      _textController.text = selectedNote.text.trim();
    }
    return Scaffold(
      appBar: AppBar(
        title: args.eMode == EditingMode.adding
            ? const Text('Add a Note')
            : const Text('Edit'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Theme.of(context).cardColor,
            ),
            onPressed: () {
              if (_titleController.text.isEmpty ||
                  _textController.text.isEmpty) {
                return;
              }
              if (args.eMode == EditingMode.adding) {
                Provider.of<Notes>(context, listen: false).addNote(
                  _titleController.text.trim(),
                  _textController.text.trim(),
                );
              }
              if (args.eMode == EditingMode.editing) {
                Provider.of<Notes>(context, listen: false).updateNote(
                  _titleController.text.trim(),
                  _textController.text.trim(),
                  args.id,
                );
              }
              if (args.eMode == EditingMode.adding) {
                Notes().addedData();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _titleController,
                style: TextStyle(
                  fontSize: 25,
                  color: MyTheme.isDark == false ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Chilanka',
                ),
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  counter: SizedBox(),
                ),
                maxLines: null,
                maxLength: 1024,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _textController,
                style: TextStyle(
                  fontSize: 18,
                  color: MyTheme.isDark == false ? Colors.black : Colors.white,
                ),
                decoration: const InputDecoration.collapsed(hintText: 'Note'),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
