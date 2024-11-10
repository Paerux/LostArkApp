import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:provider/provider.dart'; // Import the extension

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor:
              themeProvider.currentThemeData.scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Home Screen!',
                  style: TextStyle(
                    color: themeProvider
                        .currentThemeData.textTheme.bodyMedium?.color,
                    fontSize: 24,
                  ),
                ),
                Container(
                  color: themeProvider.currentThemeData.primaryColor,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'This box uses dropdown color!',
                    style: TextStyle(
                        color: themeProvider
                            .currentThemeData.textTheme.bodyMedium?.color),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
