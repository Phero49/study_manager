import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../db/db.dart';

class MyStats extends StatefulWidget {
  @override
  _MyStatsState createState() => _MyStatsState();
}

class _MyStatsState extends State<MyStats> {
  void trying() async {
    var db = Db();
    var xx = await db.getRecords();
    print(xx);
  }

  Widget grids() {
    return GridView.builder(
      itemCount: 6, // Number of items to display
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue, // Replace with your desired item widget
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  'Unit ${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(
                  '0$index hrs',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ])),
        );
      },
    );
  }

  Widget titles(String title) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)));
  }

  @override
  Widget build(BuildContext context) {
    trying();

    return Container(
      child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 6),
          children: [
            titles("Progress this week "),
            MyLineChart(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              titles("Total hours each"),
              TextButton(
                onPressed: () {
                  // Add code here to handle button press
                },
                child: Text(
                  'Show Chart',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
              )
            ]),
            Container(height: 220, child: grids())
          ]),
    );
  }
}

class MyLineChart extends StatefulWidget {
  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<FlSpot> spots = const [
    FlSpot(1, 1),
    FlSpot(2, 2.8),
    FlSpot(3, 1.2),
    FlSpot(4, 2.8),
    FlSpot(5, 2.6),
    FlSpot(6, 3.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 16, bottom: 15),
        height: 230,
        child: LineChart(
          LineChartData(
            maxY: 8,
            maxX: 7,
            minY: 0,
            minX: 1,

            // backgroundColor:Colors.grey
            //   ,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: true)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(spots: spots),
            ],
          ),
          swapAnimationDuration: Duration(milliseconds: 150),
          swapAnimationCurve: Curves.linear,
        ));
  }
}
