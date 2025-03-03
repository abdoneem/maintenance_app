import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'utils/app_localizations.dart';

void main() {
  runApp(MaintenanceApp());
}

class MaintenanceApp extends StatefulWidget {
  @override
  _MaintenanceAppState createState() => _MaintenanceAppState();
}

class _MaintenanceAppState extends State<MaintenanceApp> {
  Locale _locale = Locale('en');

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language') ?? 'en';
    if (!mounted) return;
    setState(() {
      _locale = Locale(languageCode);
    });
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
  void initState() {
    super.initState();
    _loadLanguage();
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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthChecker(onLanguageChange: _changeLanguage, locale: _locale),
    );
  }
}

class AuthChecker extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Locale locale;

  AuthChecker({required this.onLanguageChange, required this.locale});

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData && snapshot.data != null) {
          return Directionality(
            textDirection:
                widget.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            child: HomePage(onLanguageChange: widget.onLanguageChange),
          );
        } else {
          return Directionality(
            textDirection:
                widget.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            child: LoginPage(onLanguageChange: widget.onLanguageChange),
          );
        }
      },
    );
  }
}
