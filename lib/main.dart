import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:extra/apps/chuck/chuck.dart';
import 'package:extra/providers/config.dart';
import 'package:extra/providers/name.dart';
import 'package:extra/screens/about.dart';
import 'package:extra/screens/home.dart';
import 'package:extra/theme/app_theme.dart';
import 'package:extra/theme/theme.dart';
import 'package:extra/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  MyTheme.isDark = (prefs.getBool('isDark') ?? false);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNotStart = false;
  @override
  void initState() {
    super.initState();
    _loadStart();
    currentTheme.addListener(() {
      super.setState(() {});
    });
  }

  _loadStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyName.myName = (prefs.getString('_userName') ?? 'User');
    setState(() {
      _isNotStart = (prefs.getBool('_isNotStart') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: Notes(),
        // ),
        ChangeNotifierProvider.value(
          value: MyName(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Extra',
        darkTheme: darkTheme(), // dark theme
        theme: lightTheme(), // light theme
        themeMode: currentTheme.currentTheme(),
        routes: {
          WelcomePage.routeName: (context) => const WelcomePage(),
          MyHomePage.routeName: (context) => const MyHomePage(),
          About.routeName: (context) => const About(),
          ChuckAPI.routeName: (context) => const ChuckAPI(),
          // MyNotes.routeName: (context) => const MyNotes(),
        },
        home: _isNotStart == false ? const WelcomePage() : const MyHomePage(),
      ),
    );
  }
}
