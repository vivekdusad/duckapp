import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);
  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      startTimer();
    });
  }

  late Timer _timer;
  int _start = 500;
  Color color = Colors.orange;

  void startTimer() {
    const oneSec = Duration(milliseconds: 300);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
        setState(() {
          color = Util.randomColor();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: widget.settingsController.themeMode,
      home: Scaffold(
        backgroundColor: color,
        body: LayoutBuilder(builder: (context, snapshot) {
          return Center(
            child: PageView(
              children: [
                Image.asset(
                  "assets/images/final.gif",
                  height: snapshot.maxHeight * 0.8,
                  width: snapshot.maxWidth * 0.8,
                ),
                Image.asset(
                  "assets/images/second.gif",
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class Util {
  static Color randomColor() {
    final List<Color> colors = [
      Colors.pink,
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.teal,
      Colors.indigo,
      Colors.green,
    ];
    final randomInt = Random().nextInt(colors.length);
    return colors[randomInt];
  }
}
