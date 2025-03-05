import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/register_page.dart'; // Register page added
import 'utils/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// ✅ Function that initializes the app with different environment files
Future<void> mainCommon(String envFile) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: envFile); // Load the correct environment file

  // Load saved language before starting the app
  String locale = await _getSavedLanguage();

  runApp(MaintenanceApp(initialLocale: Locale(locale)));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await dotenv.load(fileName: ".env");

  // Load saved language before starting the app
  String locale = await _getSavedLanguage();

  runApp(MaintenanceApp(initialLocale: Locale(locale)));
}

Future<String> _getSavedLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('language') ?? 'en'; // Default to English
}

class MaintenanceApp extends StatefulWidget {
  final Locale initialLocale;

  const MaintenanceApp({super.key, required this.initialLocale});

  @override
  _MaintenanceAppState createState() => _MaintenanceAppState();
}

class _MaintenanceAppState extends State<MaintenanceApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  Future<void> _changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    if (!mounted) return;
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maintenance App',
      locale: _locale,
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null &&
            supportedLocales.any(
              (supported) => supported.languageCode == locale.languageCode,
            )) {
          return locale;
        }
        return Locale('en');
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      routes: {
        '/':
            (context) =>
                AuthChecker(onLanguageChange: _changeLanguage, locale: _locale),
        '/login': (context) => LoginPage(onLanguageChange: _changeLanguage),
        '/home': (context) => HomePage(onLanguageChange: _changeLanguage),
        '/register':
            (context) => RegisterPage(
              onLanguageChange: _changeLanguage,
            ), // Added register page
      },
    );
  }
}

class AuthChecker extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Locale locale;

  const AuthChecker({
    super.key,
    required this.onLanguageChange,
    required this.locale,
  });

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await Future.delayed(Duration(seconds: 1)); // Simulate API delay

    if (token != null) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      ); // Go to Home if logged in
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/login',
      ); // Go to Login if not logged in
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status when app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    ); // Show loader while checking login status
  }
}
