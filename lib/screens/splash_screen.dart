import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants.dart';
import 'package:globe_trek/screens/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/image.png",
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.xxl),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GlobeTrek',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Discover. Navigate. Experience',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.xl),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered By',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Al-Najaf IT Solutions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
