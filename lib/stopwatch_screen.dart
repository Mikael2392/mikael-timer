import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  int verstricheneSekunden = 0;
  bool isRunning = false;

  void startStopwatch() {
    if (!isRunning) {
      isRunning = true;
      runStopwatch();
    }
  }

  Future<void> runStopwatch() async {
    while (isRunning) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        verstricheneSekunden++;
      });
    }
  }

  void stopStopwatch() {
    setState(() {
      isRunning = false;
    });
  }

  void resetStopwatch() {
    stopStopwatch();
    setState(() {
      verstricheneSekunden = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stoppuhr',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4B2F3E),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4B2F3E),
              Color(0xFFB16F92),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(verstricheneSekunden ~/ 60).toString().padLeft(2, '0')}:${(verstricheneSekunden % 60).toString().padLeft(2, '0')}',
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startStopwatch,
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: stopStopwatch,
                    child: const Text('Stop'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: resetStopwatch,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
