import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final Duration duration;

  const TimerWidget({Key? key, this.duration = Duration.zero})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  Timer? _timer;

  void timerStart() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        seconds++;

        if (seconds == 60) {
          seconds = 0;
          minutes++;

          if (minutes == 60) {
            minutes = 0;
            hours++;
          }
        }
      });
    });
  }

  TextStyle h1Style = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timerStart();

    // State initialization code goes here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // Widget code goes here
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("$hours", style: h1Style),
        SizedBox(
          width: 10,
        ),
        Text(":", style: h1Style),
        SizedBox(
          width: 10,
        ),
        Text("$minutes", style: h1Style),
        SizedBox(
          width: 10,
        ),
        Text(":", style: h1Style),
        SizedBox(
          width: 10,
        ),
        Text("$seconds", style: h1Style)
      ]),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Perform stop action
            },
            child: Text('Stop'),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform pause action
            },
            child: Text('Pause'),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform restart action
            },
            child: Text('Restart'),
          ),
        ],
      )
    ]));
  }
}
