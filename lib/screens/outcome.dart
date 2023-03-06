import 'package:flutter/material.dart';
import '../db/db.dart';
import './outcome.dart';
import 'package:flutter/services.dart';
import './read_page.dart';
//import 'package:clipboard/clipboard.dart';

class Outcomes  extends StatelessWidget {
  String unit;
    String _outcome; 
    
   Outcomes(this.unit,this._outcome);
    @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              Tab(text: 'Lesson '),
              Tab(text: 'Questions'),
              
            ],
          ),
        ),
        body: TabBarView(
         children: [
              _Lesson(unit,_outcome),
                Center(child: Text('This is Tab 2')),
         
          ],
        ),
      ),
    );
  }
}


//;import 'package:flutter/material.dart';

class _Lesson  extends StatelessWidget {
String _unit;
    String _outcome;
    _Lesson (this._unit,this._outcome);
    
    Future<List<String>> getCourses() async {
   var db = Db() ;
      
     List<String> keys = await db. getEachOutcome (_unit,_outcome);
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
          final lessons = snapshot.data!;
            
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              
                String alpha = lessons[index].substring(0,4).replaceAll(". ","");
                String lesson = lessons[index].substring(4,lessons[index].length);
                


// Use the TextSpan in a RichText widget


              return GestureDetector(
                  onTap:() {
              showDialog(
  context: context,
  builder: (BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
      //  width: double.infinity,
       // height: double.infinity,
        child: Padding(
  padding: EdgeInsets.all(8.0),
  child: Column(
      
      
    mainAxisSize: MainAxisSize.min, // Set main axis size to min
    children: [
      Text("You're about to read ",style: TextStyle (fontWeight:FontWeight.bold,fontSize:17)),
    
        SizedBox (height :7),
        Text (_unit +". "+ _outcome, style: TextStyle (fontWeight:FontWeight.w300,fontSize:14) ),
      SizedBox (height:10),
        ElevatedButton(
        onPressed: () {
             
            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Read(unit: _unit,outcome: _outcome, lesson:lessons[index]),
  ),
);
        },
        child: Text("Read"),
      ),
    ],
  ),
)
// your widget here
  )
    );
  },
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
                   child: Column (children:[
                    
                      
    Align(
  alignment: Alignment.topRight,
  child: GestureDetector(
    child: Text('Copy',style:TextStyle (fontSize: 9)),
    
      onTap: () {/*
      FlutterClipboard.copy('hello flutter friends').then(( value ) => print('copied'));  */
       
      Clipboard.setData(ClipboardData(text: lesson ));
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Text copied to clipboard',style:TextStyle (color:Colors.green )),
     ));
    },
  ),
),
                   
                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                          
               Container(
  width: 32,
  height: 32,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
    color: Colors.white,
  ),
  child: Center(
    child: Text(
      alpha,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
        SizedBox(width:  8),
                          Expanded(child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      
         Text(
      lesson,
      style: TextStyle(
        fontSize: 14,
          color:Colors.black,
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
                                                   //row
                                                   ])]))
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
