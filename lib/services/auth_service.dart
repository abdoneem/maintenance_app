import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://your-dotnet-core-api.com/api/auth";

  /// Login Method
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': 'Invalid credentials'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Login failed. Error: $e'};
    }
  }

  /// Register Method
  static Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Registration successful'};
      } else {
        return {'success': false, 'message': 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Logout Method
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// Get Token (for authentication headers)
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
