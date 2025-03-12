import 'package:flutter/material.dart';
import 'package:maintenance_app/extensions/context_extensions.dart';
import 'package:maintenance_app/screens/account_page.dart';

class HomePage extends StatelessWidget {
  final Function(String) onLanguageChange;

  const HomePage({super.key, required this.onLanguageChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      appBar: AppBar(
        title: Text(context.tr("Maintenance Dashboard")),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language), // Language Icon
            onSelected: (String value) {
              onLanguageChange(value);
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: Text(context.tr('English')),
                  ),
                  PopupMenuItem(value: 'ar', child: Text(context.tr('Arabic'))),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr("Welcome to Maintenance App"),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true, // ✅ Fixes extra space issue
                physics:
                    NeverScrollableScrollPhysics(), // ✅ Prevents nested scrolling
                children: [
                  _buildCard(context.tr("Tasks"), Icons.task, Colors.orange),
                  _buildCard(context.tr("Reports"), Icons.report, Colors.green),
                  _buildCard(
                    context.tr("Settings"),
                    Icons.settings,
                    Colors.blueGrey,
                  ),
                  _buildCard(
                    context.tr("Support"),
                    Icons.help,
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 4,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
