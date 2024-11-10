import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the whole AlertDialog with Consumer
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: themeProvider.currentThemeData.primaryColor,
          child: AlertDialog(
            backgroundColor:
                themeProvider.currentThemeData.cardColor, // Background color
            title: Text('Settings',
                style: TextStyle(
                    color: themeProvider.currentThemeData.textTheme.bodyMedium
                        ?.color)), // Title color
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode',
                    style: TextStyle(
                        color: themeProvider.currentThemeData.textTheme
                            .bodyMedium?.color)), // Label color
                Switch(
                  value: themeProvider.currentTheme == 'dark',
                  onChanged: (value) {
                    themeProvider.setTheme(value ? 'dark' : 'light');
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close button action
                child: Text('Close',
                    style: TextStyle(
                        color: themeProvider.currentThemeData.textTheme
                            .bodyMedium?.color)), // Button text color
              ),
            ],
          ),
        );
      },
    );
  }
}
