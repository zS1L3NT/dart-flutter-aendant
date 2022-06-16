import 'package:aendant/features/alert/alert.dart';
import 'package:aendant/features/home/home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AlertScreen()),
          );
        },
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Text(""),
        ),
      ),
    );
  }
}
