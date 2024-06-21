import 'package:boxtia_inventory/Screens/Home.dart';
import 'package:boxtia_inventory/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String hiveBoxName = 'userBox';
  final String saveKeyName = 'userLoggedIn';

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/asset/SplashScreen_page-0001.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final Box<bool> userBox = Hive.box<bool>(hiveBoxName);
    bool? userLoggedIn = userBox.get(saveKeyName);

    // Check login status
    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin(context);
    } else {
      // Navigate to HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
    }
  }

  // Go to login page
  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => welcomePage(),
      ),
    );
  }
}
