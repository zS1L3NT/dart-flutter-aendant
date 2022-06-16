import 'package:aendant/app.dart';
import 'package:aendant/features/nextofkin/nextofkin.dart';
import 'package:aendant/features/owner/owner.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  ShakeDetector? detector;
  bool _isCurrentScreen = true;
  double _threshold = 1.5;

  @override
  void initState() {
    super.initState();

    setupDetector();
  }

  void setupDetector() {
    debugPrint("Setting up detector with a threshold of $_threshold");
    detector?.stopListening();
    detector = ShakeDetector.autoStart(
      shakeThresholdGravity: _threshold,
      onPhoneShake: () {
        if (_isCurrentScreen) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TimerScreen()),
          );
        }
      },
    );
    detector!.startListening();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _isCurrentScreen = true;
  }

  @override
  void didPushNext() {
    _isCurrentScreen = false;
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AlertScreen()),
        );
      },
      onLongPress: () {
        double threshold = _threshold;

        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("Change Threshold"),
              content: StatefulBuilder(
                builder: (context, _setState) {
                  return SizedBox(
                    height: 90,
                    child: Column(
                      children: [
                        Slider.adaptive(
                          value: threshold,
                          min: 1,
                          max: 5,
                          divisions: 400,
                          onChanged: (value) {
                            _setState(() => threshold = value);
                          },
                        ),
                        Text(threshold.toStringAsFixed(2)),
                      ],
                    ),
                  );
                },
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    setState(() {
                      _threshold = threshold;
                      setupDetector();
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 48),
              const Text(
                "Your Necklace",
                style: TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 48),
              const Text(
                "BATTERY",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/battery.png",
                    scale: 0.5,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "60%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "STATUS",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 48),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Next-Of-Kin 1",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Relationship\nContact Number",
                    style: TextStyle(
                        // fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
              label: "",
            ),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
