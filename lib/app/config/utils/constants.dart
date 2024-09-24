import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Constants {
  /// cosntantes del enviroment
  static String supabaseUrl = dotenv.get("SUPABASE_URL");
  static String supabaseKey = dotenv.get("SUPABASE_KEY");
  static String googleWebClientId = dotenv.get("GOOGLE_WEB_CLIENT_ID");
}
