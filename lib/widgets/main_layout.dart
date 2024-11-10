import 'package:flutter/material.dart';
import 'package:lost_time/screens/gold_calculator.dart';
import 'package:lost_time/screens/home_screen.dart';
import 'package:lost_time/widgets/side_menu.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const GoldCalculatorScreen(),
  ];

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar here now
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          // Drawer only on smaller screens (less than 600px)
          if (constraints.maxWidth < 600) {
            return Drawer(
              child: SideMenu(onNavigate: _onNavigate),
            );
          }
          return Container(); // No drawer for larger screens
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Show side menu only on larger screens
              if (constraints.maxWidth >= 600)
                SideMenu(onNavigate: _onNavigate),
              // Main content area on right side
              Expanded(
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth < 600 ? 60 : 0),
                      child: IndexedStack(
                        index: _currentIndex,
                        children: _screens,
                      ),
                    ),
                    // Show hamburger icon at the top-left for small screens
                    if (constraints.maxWidth < 600)
                      Positioned(
                        top: 16,
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context)
                                .openDrawer(); // Open the side menu
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
