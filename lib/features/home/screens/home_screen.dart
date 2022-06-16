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
  bool _isCurrentScreen = true;
  late final ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    double threshold = 1.5;
    debugPrint("Shake Threshold: $threshold");

    detector = ShakeDetector.autoStart(
      shakeThresholdGravity: threshold,
      onPhoneShake: () {
        if (_isCurrentScreen) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TimerScreen()),
          );
        }
      },
    );
    detector.startListening();
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
