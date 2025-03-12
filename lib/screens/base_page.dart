import 'package:flutter/material.dart';
import 'package:maintenance_app/extensions/context_extensions.dart';
import 'home_page.dart';
import 'account_page.dart';

class BasePage extends StatefulWidget {
  final Function(String) onLanguageChange;

  const BasePage({super.key, required this.onLanguageChange});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(onLanguageChange: widget.onLanguageChange),
      Text("Requests"), // Replace with RequestsPage
      Text("Help"), // Replace with HelpPage
      AccountPage(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Switch content dynamically
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: context.tr("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: context.tr("Requests"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: context.tr("Help"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: context.tr("Account"),
          ),
        ],
      ),
    );
  }
}
