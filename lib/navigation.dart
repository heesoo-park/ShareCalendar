import 'package:flutter/material.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/second_page.dart';
import 'package:main/pages/third_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIdx,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIdx = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: '일정',
            selectedIcon: Icon(
              Icons.calendar_month,
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            label: '지도',
            selectedIcon: Icon(
              Icons.map_outlined,
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSecondaryContainer,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: '프로필',
            selectedIcon: Icon(
              Icons.person,
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSecondaryContainer,
            ),
          ),
        ],
        animationDuration: Duration(milliseconds: 500),
      ),
      body: IndexedStack(
        index: _selectedIdx,
        children: [
          HomePage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
    );
  }
}
