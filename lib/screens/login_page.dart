import 'package:flutter/material.dart';
import 'package:maintenance_app/screens/base_page.dart';
import 'package:maintenance_app/extensions/context_extensions.dart'; // ✅ Import context.tr()
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function(String) onLanguageChange;

  const LoginPage({super.key, required this.onLanguageChange});

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
              (context) => BasePage(onLanguageChange: widget.onLanguageChange),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? context.tr('Login Failed')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color
      appBar: AppBar(
        title: Text(context.tr("Login")), // ✅ Capitalized
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false, // ✅ Removes back button
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language), // 🌍 Language Icon
            onSelected: (String value) {
              widget.onLanguageChange(value);
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: Text(context.tr('English')),
                  ), // ✅ Capitalized
                  PopupMenuItem(
                    value: 'ar',
                    child: Text(context.tr('Arabic')),
                  ), // ✅ Capitalized
                ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100), // App Logo
              const SizedBox(height: 20),
              _buildTextField(
                _emailController,
                Icons.email,
                context.tr('Email'),
              ), // ✅ Capitalized
              const SizedBox(height: 10),
              _buildTextField(
                _passwordController,
                Icons.lock,
                context.tr('Password'), // ✅ Capitalized
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        context.tr("Login"), // ✅ Capitalized
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  context.tr(
                    "Don't Have An Account? Register",
                  ), // ✅ Capitalized
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    IconData icon,
    String label, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
