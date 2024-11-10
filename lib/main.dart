import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:lost_time/widgets/main_layout.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set minimum window size for desktop platforms
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    setWindowTitle('Lost Time');
    setWindowMaxSize(const Size(1920, 1080));
    setWindowMinSize(const Size(400, 400));
  }

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.currentThemeData,
      home: const MainLayout(),
    );
  }
}
