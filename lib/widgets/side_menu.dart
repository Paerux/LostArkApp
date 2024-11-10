import 'package:flutter/material.dart';
import 'package:lost_time/config/theme_provider.dart';
import 'package:lost_time/widgets/settings_dialog.dart'; // Import the extension
import 'package:provider/provider.dart'; // Import ThemeProvider

class SideMenu extends StatelessWidget {
  final Function(int) onNavigate;

  const SideMenu({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen for theme changes explicitly
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: themeProvider
              .currentThemeData.primaryColor, // Set background color
          width: 250,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Push items to top and bottom
            children: [
              Column(
                children: [
                  // Home Button
                  _buildSideMenuButton(
                      icon: Icons.home,
                      onPressed: () => onNavigate(0),
                      themeData:
                          themeProvider.currentThemeData // Navigate to Home
                      ),
                  const SizedBox(height: 20),
                  // Gold Calculator Button
                  _buildSideMenuButton(
                      icon: Icons.calculate,
                      onPressed: () => onNavigate(1),
                      themeData: themeProvider
                          .currentThemeData // Navigate to Gold Calculator
                      ),
                  const SizedBox(height: 20),
                ],
              ),
              // Settings Button placed at the bottom
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20), // Add some padding to bottom
                child: _buildSideMenuButton(
                    icon: Icons.settings,
                    onPressed: () => showDialog(
                          context: context,
                          builder: (context) => const SettingsDialog(),
                        ),
                    themeData: themeProvider.currentThemeData),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to build side menu buttons
  Widget _buildSideMenuButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ThemeData themeData,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor:
            themeData.buttonTheme.colorScheme?.surface, // Set button color
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: themeData.iconTheme.color, // Set icon color
      ),
    );
  }
}
