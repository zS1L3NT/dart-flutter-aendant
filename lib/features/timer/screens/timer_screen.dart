import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int time = 20;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), decrement);
  }

  void decrement() {
    if (!mounted) return;

    if (time > 0) {
      setState(() {
        time--;
      });
      Future.delayed(const Duration(seconds: 1), decrement);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 350,
            width: 250,
            child: Column(
              children: [
                const Text(
                  "You had a fall",
                  style: TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: "Next-of-kin contacted: Son, Daughter\n"),
                      const TextSpan(text: "Health Authorities will be informed in "),
                      TextSpan(
                        text: time.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: "s"),
                    ],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("I'm Fine"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 120),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
