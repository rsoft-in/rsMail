import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:rsMail/pages/app.dart';
import 'package:rsMail/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(800, 600);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email',
      themeMode: ThemeMode.light,
      theme: theme(),
      darkTheme: themeDark(),
      home: const EmailApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
