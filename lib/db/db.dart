import 'dart:convert';
//import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import './myData.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  Future<void> addDailyRecord(Map record) async {
    final box = await Hive.openBox(_recordBox);

    box.add(record);
  }

  Future<List> getRecords() async {
    final box = await Hive.openBox(_recordBox);
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: 7));
    DateTime endDate = now;
    List dataList = box.values
        .where((item) =>
            item.startTime.isAfter(startDate) &&
            item.startTime.isBefore(endDate))
        .toList();
    print(dataList);
    return [];
  }
}

/*
@HiveType (typeId: 0)

class DailyRecord {
  int startTime;
  int endTime;
  String unit;
  String outcome;
  String lesson;
  DailyRecord(
      {required this.endTime,
      required this.lesson,
      required this.outcome,
      required this.startTime,
      required this.unit});
}

class DailyRecordAdapter extends TypeAdapter<DailyRecord> {
  @override
  final int typeId = 0; // unique identifier for the adapter

  @override
  DailyRecord read(BinaryReader reader) {
    final startTime = reader.readInt();
    final endTime = reader.readInt();
    final unit = reader.readString();
    final outcome = reader.readString();
    final lesson = reader.readString();
    return DailyRecord(
      startTime: startTime,
      endTime: endTime,
      unit: unit,
      outcome: outcome,
      lesson: lesson,
    );
  }

  @override
  void write(BinaryWriter writer, DailyRecord record) {
    writer.writeInt(record.startTime);
    writer.writeInt(record.endTime);
    writer.writeString(record.unit);
    writer.writeString(record.outcome);
    writer.writeString(record.lesson);
  }
}
*/
