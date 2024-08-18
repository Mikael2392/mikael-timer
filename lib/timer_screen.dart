import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int verbleibendeSekunden = 0;
  bool isRunning = false;
  late Future<void> timerFuture;
  final TextEditingController _controller = TextEditingController();

  void startTimer() {
    final input = int.tryParse(_controller.text);
    if (input != null && input > 0 && !isRunning) {
      setState(() {
        verbleibendeSekunden = input;
        isRunning = true;
      });
      timerFuture = runTimer();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  Future<void> runTimer() async {
    while (isRunning && verbleibendeSekunden > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (verbleibendeSekunden > 0) {
        setState(() {
          verbleibendeSekunden--;
        });
      }
    }
    if (verbleibendeSekunden == 0) {
      stopTimer();
    }
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      verbleibendeSekunden = 0;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timer',
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
                '${(verbleibendeSekunden ~/ 60).toString().padLeft(2, '0')}:${(verbleibendeSekunden % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 72, // Größere Schriftgröße für bessere Lesbarkeit
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ändere die Farbe je nach Hintergrund
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter time in seconds',
                    fillColor: Color.fromARGB(255, 241, 236, 236),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,
                    child: const Text('Start'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: stopTimer,
                    child: const Text('Stop'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: resetTimer,
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
