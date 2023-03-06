import 'package:flutter/material.dart';
import '../db/db.dart';
import './outcome.dart';
class MyCourse  extends StatelessWidget {
  String unit;
    MyCourse(this.unit);
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
          title: Text(unit),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Outcomes'),
              Tab(text: 'Questions'),
              Tab(text: 'stastics'),
            ],
          ),
        ),
        body: TabBarView(
         children: [
              _Outcomes(unit),
                Center(child: Text('This is Tab 2')),
            Center(child: Text('This is Tab 3')),
          ],
        ),
      ),
    );
  }
}


//;import 'package:flutter/material.dart';

class _Outcomes  extends StatelessWidget {
String _unit;
    _Outcomes (this._unit);
    
    Future<List<String>> getCourses() async {
   var db = Db() ;
      
     List<String> keys = await db.getOutcomes(_unit);
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
              
                List<String> splitText = courses[index].split(':');
                


// Use the TextSpan in a RichText widget


              return GestureDetector(
                  onTap:() {
                      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Outcomes(_unit,courses[index]),
  ),
);
                      },
                  child:Container(
                decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
 ), 
                padding:EdgeInsets.only(top:14,bottom:14,left:8,right:8),
                      
 margin:EdgeInsets.only(top:10,bottom:10,left:8,right:8),
                      child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      
         Text(
      splitText[0],
      style: TextStyle(
        fontSize: 14,
          color:Colors.black,
        fontWeight: FontWeight
          .bold,
      ),
    ),   SizedBox(height
                  :10)
                          
                  ,
                          Text(
      splitText[1],
      style: TextStyle(
        fontSize: 14,
          color:Colors.grey
          [600],
        fontWeight: FontWeight
          .w600,
      ),
    ),
   SizedBox (height:13),
   Text(
      "04,March 2023 at 16:40",
      style: TextStyle(
        fontSize: 12,
          color:Colors.black
          ,
        fontWeight: FontWeight
          .w400,
      ),
    )                      
                      ]))
);
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
