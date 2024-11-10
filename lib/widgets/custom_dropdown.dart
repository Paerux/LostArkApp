import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:provider/provider.dart'; // Import the extension

class CustomDropdown extends StatelessWidget {
  final int selectedValue;
  final ValueChanged<int?> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Access the dropdownColor and text color from the theme
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(
        //highlightColor: Colors.transparent,
        //splashColor: Colors.transparent,
        //hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        textSelectionTheme:
            const TextSelectionThemeData(selectionColor: Colors.transparent),
      ),
      child: DropdownButton<int>(
        value: selectedValue,
        items: [4, 8, 16].map((size) {
          return DropdownMenuItem<int>(
            value: size,
            child: Container(
              color: Colors.transparent,
              child: Text(
                '$size Players',
                style: TextStyle(
                  color: themeProvider.currentThemeData.textTheme.bodyMedium
                      ?.color, // Use theme-based text color
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        // Set the background color of the dropdown items
        dropdownColor: themeProvider.currentThemeData.primaryColor,
        // Remove the underline
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
