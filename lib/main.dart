import 'package:app/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  build(context) {
    var seedColor = const Color.fromARGB(255, 148, 35, 42);
    var lightScheme = ColorScheme.fromSeed(
        seedColor: seedColor, brightness: Brightness.light);
    var darkScheme =
        ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);
    var theme = ThemeData(colorScheme: lightScheme, useMaterial3: true);
    var darkTheme = ThemeData(colorScheme: darkScheme, useMaterial3: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covfamikoi App',
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeView(),
    );
  }
}
