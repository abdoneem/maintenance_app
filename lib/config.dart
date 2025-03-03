import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl {
    return dotenv.env['ENV'] == 'production'
        ? dotenv.env['BASE_URL'] ?? "https://default.prod.com"
        : dotenv.env['DEV_BASE_URL'] ?? "https://default.dev.com";
  }
}
