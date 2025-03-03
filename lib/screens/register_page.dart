import 'package:flutter/material.dart';
import 'package:maintenance_app/extensions/context_extensions.dart';
import 'login_page.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function(String) onLanguageChange;

  const RegisterPage({super.key, required this.onLanguageChange});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    final response = await AuthService.register(email, password);

    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => LoginPage(onLanguageChange: widget.onLanguageChange),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'] ?? context.tr('Registration failed'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('Register')),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              widget.onLanguageChange(value);
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(value: 'en', child: Text('English')),
                  PopupMenuItem(value: 'ar', child: Text('العربية')),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: context.tr('Email')),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: context.tr('Password')),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _register,
                  child: Text(context.tr('Register')),
                ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(context.tr('Already have an account')),
            ),
          ],
        ),
      ),
    );
  }
}
