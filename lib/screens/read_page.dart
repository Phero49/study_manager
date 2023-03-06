import 'package:flutter/material.dart';
import './timer.dart';  
class Read  extends StatelessWidget {
  String unit;
    String outcome; 
    String lesson ;
   Read({required this.unit, required this.outcome,required ,required this.lesson });
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
             TimerWidget(),
         
                Center(child: Text('This is Tab 2')),
         
          ],
        ),
      ),
    );
  }
}
