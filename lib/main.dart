import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import "./db/db.dart";
import "./screens/home.dart";
import "./screens/course.dart";
void main() async {
    //WidgetsFlutterBinding.ensureInitialized();
  
//var appDocDir = await //getApplicationDocumentsDirectory();
//String appDocPath = appDocDir.path;
 
   await Hive.initFlutter();
  // Initialize Hive'
 // Hive.registerAdapter(DailyRecordAdapter());

bool exists = await Hive.boxExists('myCourses');
    print(exists);
    if(exists){
        
        var db = Db();
        //print("kkk ");
    await  db.addAppDataToBox ();
     db.historyBox();
        }
    
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
  ///  '/course': (context) => MyCourse(),
  },
      title: 'my study guid',
      home: HomePage()
    );
  }
}
