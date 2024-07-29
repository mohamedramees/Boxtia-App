import 'package:boxtia_inventory/Screens/Home_Page.dart';
import 'package:boxtia_inventory/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
   final AuthService _authService = AuthService();
  final String hiveBoxName = 'userBox';
  final String saveKeyName = 'userLoggedIn';

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    _checkAuth();
  }


  Future<void> _checkAuth() async {
    bool authenticated = await _authService.authenticate();
    if (!authenticated) {
      _showAuthFailedDialog();
    }
  }

  void _showAuthFailedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Authentication Failed'),
        content: Text('Unable to authenticate. The app will close now.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();

              SystemNavigator.pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
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
          builder: (ctx) => Home_Page(),
        ),
      );
    }
  }

  // Go to login page
  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => Home_Page(),
      ),
    );
  }
}
