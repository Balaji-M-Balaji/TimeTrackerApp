import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/model.dart';

class LastLoginController {
  Future<List<SavedDataEntry>> getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(await prefs.getStringList('savedData'));
    List<String> savedData = await prefs.getStringList('savedData') ?? [];
    print(savedData.toString());
    return savedData.map((entry) => SavedDataEntry.fromString(entry)).toList();
  }
}