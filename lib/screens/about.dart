import 'package:flutter/material.dart';

import 'package:extra/providers/config.dart';
import 'package:extra/providers/url.dart';
import 'package:extra/screens/drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class About extends StatelessWidget {
  static const routeName = '/about';

  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[500],
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
                myDrawer(context, Colors.blue, DrawerItems.about);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 65.0,
                backgroundImage:
                    NetworkImage('https://twitter.com/MrSneakyTurtle/photo/'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'MrSneakyTurtle',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 25.0,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "This app is still in development. Check github for updates. Some under the hood improvements are frequently done."),
                    const SizedBox(
                      height: 26.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            final Uri url = Uri.parse(
                                'https://twitter.com/mrsneakyturtle/');
                            launchInWebView(url);
                          },
                          icon: SvgPicture.asset(
                              'assets/images/twitter-brands.svg',
                              color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            final Uri url = Uri.parse('https://github.com/');
                            launchInWebView(url);
                          },
                          icon: SvgPicture.asset(
                              'assets/images/github-brands.svg'),
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
    );
  }
}
