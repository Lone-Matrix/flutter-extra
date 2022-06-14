import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:extra/apps/notes/add_notes.dart';
import 'package:extra/apps/notes/provider/notes_provider.dart';
import 'package:extra/providers/config.dart';
import 'package:extra/screens/drawer.dart';

enum EditingMode {
  adding,
  editing,
}

class CustomArgument {
  String id;
  EditingMode eMode;

  CustomArgument({required this.id, required this.eMode});
}

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);
  static const routeName = '/notes';

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  int maxLines = 3;
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5.0,
        icon: const Icon(Icons.add),
        label: const Text('Add a Note'),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddNotes.routeName,
            arguments: CustomArgument(
              eMode: EditingMode.adding,
              id: '',
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                myDrawer(
                  context,
                  Colors.blue,
                  DrawerItems.notes,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My Notes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                color: Colors.blue,
                fontSize: 20.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.pink[300],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<Notes>(context, listen: false)
                    .fetchAndSetNotes(),
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<Notes>(
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Text('Not Notes found, start adding some!!'),
                          ),
                        ),
                        builder: (ctx, notes, child) => ListView.builder(
                          itemCount: notes.items.length,
                          itemBuilder: (ctx, index) => Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 8.0,
                              top: 8.0,
                              bottom: 3.0,
                            ),
                            child: Dismissible(
                              key: ValueKey(notes.items[index].id),
                              background: Container(
                                color: Theme.of(context).errorColor,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this Note?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Cancel');
                                          // setState(() {});
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'OK');
                                          Provider.of<Notes>(context,
                                                  listen: false)
                                              .deleteNote(
                                            notes.items[index].id,
                                          );
                                          Notes().removedData();
                                          //setState(() {});
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text("Note Deleted!!"),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                setState(() {});
                              },
                              child: GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    expanded = !expanded;
                                  });
                                  if (expanded) {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("All Notes are Expanded!!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Notes are resized to normal!!"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: ListTile(
                                  title: Text(
                                    notes.items[index].title,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  subtitle: Text(
                                    notes.items[index].text,
                                    maxLines: expanded
                                        ? notes.items[index].text.length
                                        : maxLines,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AddNotes.routeName,
                                      arguments: CustomArgument(
                                        eMode: EditingMode.editing,
                                        id: notes.items[index].id,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
