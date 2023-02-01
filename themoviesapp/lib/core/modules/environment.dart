import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => '.env.development';
  static String get apiUrl => dotenv.env['API_KEY'] ?? 'API URL NOT FOUND!';
}
