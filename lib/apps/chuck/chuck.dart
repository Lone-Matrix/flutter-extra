import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:extra/apps/chuck/joke.dart';
import 'package:extra/screens/drawer.dart';
import 'package:extra/providers/config.dart';

Future<Joke> fetchJoke() async {
  final response = await http.get(
    Uri.parse('https://api.chucknorris.io/jokes/random'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

class ChuckAPI extends StatefulWidget {
  const ChuckAPI({Key? key}) : super(key: key);

  static const routeName = '/chuckAPI';

  @override
  State<ChuckAPI> createState() => _ChuckAPIState();
}

class _ChuckAPIState extends State<ChuckAPI> {
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchJoke();
  }

  late Future<Joke> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
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
                myDrawer(context, Colors.purpleAccent, DrawerItems.chuckAPI);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Center(
          child: FutureBuilder<Joke>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(snapshot.data!.value),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            futureAlbum = fetchJoke();
          });
        },
        tooltip: 'Next Joke',
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
}
