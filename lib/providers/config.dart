library config.global;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:extra/theme/theme.dart';

MyTheme currentTheme = MyTheme();
SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;

enum DrawerItems {
  home,
  about,
  chat,
  notes,
  todo,
  chuckAPI
  // add more
}
