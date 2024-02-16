import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';
import 'package:harang_client/widgets/main_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 133,
              right: 32,
            ),
            width: double.infinity,
            child: const MainLogo(),
          ),
        ],
      ),
    );
  }
}
