import 'package:flutter/material.dart';
import 'home_page.dart';
import '../services/auth_service.dart';
import '../utils/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final Function(String) onLanguageChange;

  LoginPage({required this.onLanguageChange});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    final response = await AuthService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (response['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => HomePage(onLanguageChange: widget.onLanguageChange),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? context.tr('login_failed')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('login')),
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
              decoration: InputDecoration(labelText: context.tr('email')),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: context.tr('password')),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _login,
                  child: Text(context.tr('login')),
                ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(context.tr('Dont have an account')),
            ),
          ],
        ),
      ),
    );
  }
}
