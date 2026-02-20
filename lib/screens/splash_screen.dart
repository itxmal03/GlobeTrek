import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: CircleAvatar(
              radius: 120,
              child: Image.asset('assets/icon.png', fit: BoxFit.cover),
            ),
          ),
          Text(
            'Discover. Navigate. Experience',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text(
                  'Powered By',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Al-Najaf IT Solutions',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
