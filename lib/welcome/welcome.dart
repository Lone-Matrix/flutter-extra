import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:extra/providers/name.dart';
import 'package:extra/screens/home.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const routeName = '/welcome';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  get raisedButtonStyle => null;

  final TextEditingController _nameController = TextEditingController();

  bool _validate = false;
  String myName = '';
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myName = Provider.of<MyName>(context).userName;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 30.0,
        ),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/monkey.jpg'),
                  radius: 24,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Welco-',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text("""Woah There!! Identify yourself.
              Who are you?"""),
            ),
            const SizedBox(
              height: 45,
            ),
            Column(
              children: <Widget>[
                TextField(
                  maxLength: 12,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _validate ? 'Can\'t Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Center(
                  child: Text(
                    "This name can be changed.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _nameController.text.isEmpty ? _validate = true : _validate = false;
          });
          if (_nameController.text.isNotEmpty) {
            myName = _nameController.text.trim();
            Provider.of<MyName>(context, listen: false).addName(myName);
            _nameController.clear();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('_isNotStart', true);
            Future.delayed(Duration.zero).then((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            });
          }
        },
        elevation: 4,
        hoverColor: Colors.red,
        backgroundColor: Colors.green,
        child: const Icon(Icons.keyboard_arrow_right_sharp),
      ),
    );
  }
}
