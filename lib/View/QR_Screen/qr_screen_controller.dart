import 'package:get/get.dart';
import 'package:loginapp/Config/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/model.dart';


class QrScreenController extends GetxController {
  var randomNumber = globals.code;


  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String qrData = globals.code.toString();
    String locationData = globals.location.toString();
    String ipData = globals.ipAddress.toString();
    String time = globals.time.toString();
    String date = globals.date.toString();

    SavedDataEntry entry = SavedDataEntry(
      qrData: qrData,
      time: time,
      date: date,
      locationData: locationData,
      ipData: ipData,
    );

    List<String> savedData = prefs.getStringList('savedData') ?? [];
    savedData.add(entry.toString());

    await prefs.setStringList('savedData', savedData);
    print("savedData$savedData");
  }
}