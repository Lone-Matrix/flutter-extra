import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:extra/providers/config.dart';
import 'package:extra/screens/drawer.dart';
import 'package:extra/providers/name.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    name = Provider.of<MyName>(context).userName;
    return Scaffold(
      drawer: null,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text('Home'),
            floating: true,
            // actions: [
            //   IconButton(
            //     onPressed: () async {
            //       SharedPreferences prefs =
            //           await SharedPreferences.getInstance();
            //       currentTheme.switchTheme(prefs);
            //     },
            //     icon: const Icon(Icons.dark_mode),
            //   ),
            // ],
            //pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //title: const Text('data'),
              centerTitle: true,
              background: Image.asset(
                'assets/images/monkey.jpg',
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, $name!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  wordSpacing: 3.5,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SourceSansPro',
                  color: Colors.blueAccent[700],
                ),
              ),
            ),
          ),
          // if (DBHelper.totalData > 0)
          //   SliverToBoxAdapter(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
          //       child: Text(
          //         DBHelper.totalData == 1
          //             ? 'You currently have ${DBHelper.totalData} Note.'
          //             : 'You currently have ${DBHelper.totalData} Notes.',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           wordSpacing: 3.5,
          //           fontSize: 24,
          //           fontWeight: FontWeight.w600,
          //           fontFamily: 'SourceSansPro',
          //           color: Colors.blue[700],
          //         ),
          //       ),
          //     ),
          //   ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text(
                  '''Welcome to our App. This is in development phase and it contains the following feature(s):

- Chuck Joke
- About Page??

Future update(s):
-Notes

Its builds are released in Github periodically. So, check for updates from About page.
''',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarColor,
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
                  Colors.teal,
                  DrawerItems.home,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
