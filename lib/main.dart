import 'package:flutter/material.dart';
import 'package:harang_client/screens/onboarding/login_screen.dart';
import 'package:harang_client/screens/onboarding/splash_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      home: const LoginScreen(),
    );
  }
}
