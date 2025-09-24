import 'dart:async';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    // start timer automatically
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  int get hours => _seconds ~/ 3600;
  int get minutes => (_seconds % 3600) ~/ 60;
  int get secs => _seconds % 60;

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel(); // cleanup when screen closes
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            twoDigits(hours),
            style: TextStyle(
              color: const Color(0xFFF9F9F9),
              fontSize: 24,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const Text(
            " : ",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            twoDigits(minutes),
            style: const TextStyle(
              color: const Color(0xFFF9F9F9),
              fontSize: 24,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
          const Text(
            " : ",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            twoDigits(secs),
            style: const TextStyle(
              color: const Color(0xFFF9F9F9),
              fontSize: 24,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
