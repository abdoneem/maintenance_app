import 'package:flutter/material.dart';
import 'package:maintenance_app/extensions/context_extensions.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(context.tr("Account")),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildAccountSection(context.tr("Personal Settings"), [
                _buildAccountItem(context.tr("My Profile"), Icons.person),
                _buildAccountItem(
                  context.tr("Saved Addresses"),
                  Icons.location_on,
                ),
              ]),
              _buildAccountSection(context.tr("App Settings"), [
                _buildAccountItem(context.tr("Language"), Icons.language),
                _buildAccountItem(context.tr("Rate App"), Icons.star),
              ]),
              _buildAccountSection(context.tr("Support & Help"), [
                _buildAccountItem(context.tr("Chat with Support"), Icons.chat),
                _buildAccountItem(
                  context.tr("WhatsApp Contact"),
                  Icons.message,
                ),
              ]),
              _buildAccountSection(context.tr("General Settings"), [
                _buildAccountItem(context.tr("About Us"), Icons.info),
                _buildAccountItem(context.tr("Privacy Policy"), Icons.policy),
              ]),
              _buildAccountSection(context.tr("Account Actions"), [
                _buildAccountItem(
                  context.tr("Delete Account"),
                  Icons.delete,
                  color: Colors.red,
                ),
                _buildAccountItem(
                  context.tr("Log Out"),
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...items,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAccountItem(
    String title,
    IconData icon, {
    Color color = Colors.blue,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: Icon(Icons.chevron_left),
        onTap: () {},
      ),
    );
  }
}
