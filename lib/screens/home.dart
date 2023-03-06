import 'package:flutter/material.dart';
import '../db/db.dart';
import './course.dart';
import './statistics.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed logic here
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Home Page'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'School'),
              Tab(text: 'Other task'),
              Tab(text: 'stastics'),
            ],
          ),
        ),
        body: TabBarView(
         children: [
              _Courses(),
                Center(child: Text('This is Tab 2')),
            MyStats()
          ],
        ),
      ),
    );
  }
}


//;import 'package:flutter/material.dart';

class _Courses extends StatelessWidget {
  Future<List<String>> getCourses() async {
   var db = Db() ;
      
     List<String> keys = await db.getBoxKeys();
      print(keys);
      // Add your asynchronous code here to fetch courses
    
    return keys;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getCourses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap:() {
                      
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MyCourse("${courses[index]}"),
  ),
);
  
                       

                      },
                  child:ListTile(
  leading: Icon(Icons.school),
  title: Text(snapshot.data![index]),
  subtitle: Text('November 8, 2023 at 3:00pm'),
));
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
