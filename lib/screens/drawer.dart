import 'package:dynamic_color/dynamic_color.dart';
import 'package:extra/apps/chuck/chuck.dart';
import 'package:extra/providers/url.dart';
import 'package:extra/screens/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:extra/providers/config.dart';
import 'package:extra/theme/theme.dart';
import 'package:extra/screens/home.dart';
import 'package:extra/providers/name.dart';

Future myDrawer(BuildContext context, Color color, DrawerItems dItem) {
  TextEditingController nameController = TextEditingController();
  String myName;
  return showModalBottomSheet(
    elevation: 10,
    // enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor:
        MyTheme.isDark ? Colors.grey[800] : Theme.of(context).canvasColor,
    context: context,
    isScrollControlled: true,
    //isDismissible: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/images/monkey.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    MyName.myName,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Center(
                child: Divider(
                  thickness: 1.3,
                  height: 12.0,
                  color: Colors.red,
                ),
              ),
              // ListTile(
              //     leading: const Icon(
              //       Icons.open_in_browser,
              //       color: Colors.red,
              //     ),
              //     title: Text(
              //       'Browser',
              //       style: Theme.of(context).textTheme.headline3,
              //     ),
              //     onTap: () {
              //       Navigator.of(context).pop();
              //       // Navigator.of(context)
              //       //     .pushReplacementNamed(MyBrowser.routeName);
              //     }),
              ListTile(
                leading: const Icon(
                  Icons.sticky_note_2_outlined,
                  color: Colors.blueGrey,
                ),
                title: Text(
                  'ChuckAPI',
                  style: Theme.of(context).textTheme.headline3,
                ),
                onTap: dItem == DrawerItems.chuckAPI
                    ? () {
                        Navigator.of(context).pop();
                      }
                    : () {
                        // Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(ChuckAPI.routeName);
                      },
              ),
              // ListTile(
              //     leading: const Icon(
              //       Icons.open_in_browser,
              //       color: Colors.red,
              //     ),
              //     title: Text(
              //       'Browser',
              //       style: Theme.of(context).textTheme.headline3,
              //     ),
              //     onTap: () {
              //       Navigator.of(context).pop();
              //       // Navigator.of(context)
              //       //     .pushReplacementNamed(MyBrowser.routeName);
              //     }),
              // ListTile(
              //   leading: const Icon(
              //     Icons.sticky_note_2_outlined,
              //     color: Colors.blue,
              //   ),
              //   title: Text(
              //     'Notes',
              //     style: Theme.of(context).textTheme.headline3,
              //   ),
              //   onTap: dItem == DrawerItems.notes
              //       ? () {
              //           Navigator.of(context).pop();
              //         }
              //       : () {
              //           Navigator.of(context).pop();
              //           // Navigator.of(context)
              //           //     .pushReplacementNamed(MyNotes.routeName);
              //         },
              // ),
              ListTile(
                leading: const Icon(
                  Icons.note_alt_outlined,
                  color: Colors.orange,
                ),
                title: Text(
                  'Notes',
                  style: Theme.of(context).textTheme.headline3,
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(MyNotes.routeName);
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.calendar_today_outlined,
              //     color: Colors.blueGrey,
              //   ),
              //   title: Text(
              //     'Calender',
              //     style: Theme.of(context).textTheme.headline3,
              //   ),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     // Navigator.of(context)
              //     //     .pushReplacementNamed(MyCalendar.routeName);
              //   },
              // ),
              const Center(
                child: Divider(
                  thickness: 1.3,
                  height: 12.0,
                  color: Colors.deepPurple,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: dItem == DrawerItems.home
                        ? () {
                            Navigator.of(context).pop();
                          }
                        : () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(MyHomePage.routeName);
                          },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.teal,
                    ),
                    icon: const Icon(Icons.home),
                    label: const Text('Home'),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MyTheme.isDark
                            ? Colors.grey[800]
                            : Theme.of(context).canvasColor,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                const SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: color,
                                    fontFamily: 'SourceSansPro',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Center(
                                  child: Divider(
                                    height: 12.0,
                                    thickness: 1.3,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  leading: const Text('Dark Theme'),
                                  trailing: Switch(
                                    value: MyTheme.isDark,
                                    onChanged: (value) async {
                                      Navigator.of(context).pop();
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      currentTheme.switchTheme(prefs);
                                    },
                                    activeTrackColor: Colors.white70,
                                    activeColor: color,
                                  ),
                                ),
                                if (dItem == DrawerItems.home)
                                  const ListTile(
                                    leading: Text('Default Avatar'),
                                    trailing: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/monkey.jpg'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ListTile(
                                  leading: const Text('Change Name'),
                                  trailing: Text(
                                    MyName.myName,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor: MyTheme.isDark
                                          ? Colors.grey[800]
                                          : Theme.of(context).canvasColor,
                                      context: context,
                                      builder: (context) => Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Center(
                                                  child: Text(
                                                    'Change Name',
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  TextField(
                                                    maxLength: 12,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    autofocus: true,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4,
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Name',
                                                      hintText: 'Name',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 45.0,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (nameController
                                                            .text.isNotEmpty) {
                                                          myName =
                                                              nameController
                                                                  .text
                                                                  .trim();
                                                          Provider.of<MyName>(
                                                                  context,
                                                                  listen: false)
                                                              .addName(myName);
                                                          nameController
                                                              .clear();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.save,
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                          const SizedBox(
                                                            width: 8.0,
                                                          ),
                                                          const Text(
                                                            "SAVE",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pink[300],
                    ),
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings'),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        context: context,
                        elevation: 10,
                        // enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        backgroundColor: MyTheme.isDark
                            ? darkDynamic?.background
                            : lightDynamic?.background ??
                                Theme.of(context).canvasColor,
                        isScrollControlled: false,
                        builder: (context) {
                          return SafeArea(
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    'About',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // fontFamily: 'SourceSansPro',
                                      color:
                                          lightDynamic?.primary ?? Colors.blue,
                                      fontSize: 20.0,
                                      letterSpacing: 2.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                  child: Divider(
                                    color: Colors.pink,
                                    thickness: 1,
                                    indent: 18,
                                    endIndent: 18,
                                  ),
                                ),
                                SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/twitter_profile.jpg'),
                                          backgroundColor: Colors.transparent,
                                          radius: 32.0,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Anup',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                        const SizedBox(
                                          height: 25.0,
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                  "This app is in development phase. Check GitHub for updates."),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      final Uri url = Uri.parse(
                                                          'https://twitter.com/mrsneakyturtle/');
                                                      launchInWebView(url);
                                                    },
                                                    icon: SvgPicture.asset(
                                                      'assets/images/twitter-brands.svg',
                                                      color: Colors.blue,
                                                      height: 36,
                                                      width: 36,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      final Uri url = Uri.parse(
                                                          'https://github.com/anupthedev/flutter-extra/releases/latest');
                                                      launchInWebView(url);
                                                    },
                                                    icon: SvgPicture.asset(
                                                      'assets/images/github-brands.svg',
                                                      color: MyTheme.isDark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      height: 36,
                                                      width: 36,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 48.0,
                                              ),
                                              const Text(
                                                "Thank you for early testing.",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const Text(
                                                "This app is for learning purpose only.",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green[500],
                    ),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('About'),
                  ),

                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //     // Navigator.of(context)
                  //     //     .pushReplacementNamed(About.routeName);
                  //   },
                  //   hoverColor: Colors.transparent,
                  //   tooltip: 'About',
                  //   icon: const Icon(Icons.info_outline),
                  // ),
                ],
              ),
            ],
          ),
        );
      }),
    ),
  );
}
