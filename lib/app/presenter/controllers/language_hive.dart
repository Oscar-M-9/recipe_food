import 'package:hive/hive.dart';

class LanguageStorage {
  static const String boxName = 'languageBox';

  static Future<void> saveLanguage(String? languageCode) async {
    var box = await Hive.openBox(boxName);
    box.put('language', languageCode);
  }

  static Future<String?> loadLanguage() async {
    var box = await Hive.openBox(boxName);
    return box.get('language');
  }
}
