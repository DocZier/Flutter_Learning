import 'package:flutter/material.dart';
import 'package:test_practic/SecondScreen/SecondScreen.dart';
import 'package:test_practic/ThirdScreen/ThirdScreen.dart';
import 'package:test_practic/FourthScreen/FourthScreen.dart';
import 'package:test_practic/FifthScreen/FifthScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = 'Александр Волков';
  String _nickname = 'volkovae';
  String _description = '';
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  double _fontSize = 16.0;

  Future<void> _navigateToChangeName() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNameScreen(
          currentName: _name,
          currentNickname: _nickname,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _name = result['name'];
        _nickname = result['nickname'];
      });
    }
  }

  Future<void> _navigateToChangeBackground() async {
    final color = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeBackgroundScreen(
          currentColor: _backgroundColor,
        ),
      ),
    );

    if (color != null) {
      setState(() => _backgroundColor = color);
    }
  }

Future<void> _navigateToChangeText() async {
    final settings = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeTextScreen(
          currentColor: _textColor,
          currentSize: _fontSize,
        ),
      ),
    );

    if (settings != null) {
      setState(() {
        _textColor = settings['color'];
        _fontSize = settings['size'];
      });
    }
  }

  Future<void> _navigateToDescription() async {
    final description = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDescriptionScreen(
          currentDescription: _description,
        ),
      ),
    );

    if (description != null) {
      setState(() => _description = description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32.0),
          color: _backgroundColor,
          child: (
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16.0,
              children: <Widget>[
                Text(
                        "Имя: $_name\n"
                        "Ник: $_nickname\n"
                        "Описание: $_description",
                  style: TextStyle(
                    color: _textColor,
                    fontSize: _fontSize
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      _navigateToChangeName();
                    },
                    child: Text(
                      "Сменить имя/ник",
                      textAlign: TextAlign.center,
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      _navigateToChangeBackground();
                    },
                    child: Text(
                      "Сменить фон",
                      textAlign: TextAlign.center,
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      _navigateToChangeText();
                    },
                    child: Text(
                      "Изменить текст",
                      textAlign: TextAlign.center,
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      _navigateToDescription();
                    },
                    child: Text(
                      "Изменить описание",
                      textAlign: TextAlign.center,
                    )
                )
              ],
            )
          ),
        )
      )
    );
  }
}