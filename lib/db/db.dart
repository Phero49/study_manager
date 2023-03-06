import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import './myData.dart';

class Db {
  String _recordBox = "Records";
  Future<void> addAppDataToBox() async {
    try {
      //print("noe");
      // Get the JSON data from the appData.json file
      var jsonString = await rootBundle.loadString('assets/courses.json');

//BidirectionalIterator
      // Convert the JSON data to Future<List<String>> Map
      var decoded = json.decode(jsonString);
// print(decoded);
      //var appData =  Map.castFrom
      //  (decoded);

      //  print("hhhhhh");
//print(decoded.runtimeType);
      //print(appData);
      // Open the myCourses Hive box
      final box = await Hive.openBox('myCourses');

      // Add the appData to the box
      for (var entry in courses_6.entries) {
        await box.put(entry.key, entry.value);
      }

      //print(decoded.keys());

      // Close the box
      //await box.close();
      //  print("done");
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> getBoxKeys() async {
    // Open the myCourses Hive box
    final box = await Hive.openBox('myCourses');
    var boxMap = box.toMap();
    // Get a list of the box keys
    var keys = boxMap.keys.toList();
//print(keys);
    // Close the box

    List<String> stringList =
        List<String>.from(keys.map((item) => item.toString()));

    ///print(stringList); // Output: [1, two, true]

    //List <String> keyStr = keys.map((e)=>e.cast<String>());

    await box.close();

    // Return the list of keys
    return stringList;
  }

  Future<List<String>> getOutcomes(String key) async {
    final box = await Hive.openBox('myCourses');

    var outcome = box.get(key);
    Map<String, List<String>> outcomeMap =
        Map<String, List<String>>.from(outcome);
    //  List<String> outcomes =   List<String>.from(outcome.map((item) => item.toString()));
    List<String> outcomes = outcomeMap.keys.toList();

    return outcomes;
  }

  ///////

  Future<List<String>> getEachOutcome(String key, String key2) async {
    final box = await Hive.openBox('myCourses');

    var outcome = box.get(key);
    Map<String, List<String>> outcomeMap =
        Map<String, List<String>>.from(outcome);
    //  List<String> outcomes =   List<String>.from(outcome.map((item) => item.toString()));
    List<String>? outcomes = outcomeMap[key2];

    return outcomes!;
  }
  //startistics

  void historyBox() async {
    final box = await Hive.openBox(_recordBox);

    for (String key in await getBoxKeys()) {
      box.put(key, []);
      print(key);
    }
    box.close();
  }

  void addRecord(Map record) async {
    final box = await Hive.openBox(_recordBox);

    box.add(record);
  }

  Future<List> getRecords() async {
    final box = await Hive.openBox(_recordBox);
    var keys = box.keys.toList();

    for (String key in keys) {
      var unit = box.get(key);
      print(unit);
    }
    return [];
  }
}

///@HiveType (typeId: 0)
/*
class DailyRecod {

}

DailyRecordAdapter extends TypeAdopter<DailyRecod>{

}*/
