import 'package:aendant/features/home/home.dart';
import 'package:flutter/material.dart';

final RouteObserver routeObserver = RouteObserver<ModalRoute<Object?>>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
    );
  }
}
