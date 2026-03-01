import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:globe_trek/core/services/auth_service.dart';
import 'package:globe_trek/repositories/auth_repository.dart';
import 'package:globe_trek/screens/splash_screen.dart';
import 'package:globe_trek/viewModels/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authService = AuthService();
  final authRepo = AuthRepository(authService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel(authRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
