import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';
import 'package:harang_client/widgets/main_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorStyles.background,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 103,
              right: 32,
            ),
            width: double.infinity,
            child: const MainLogo(),
          ),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/splash_ground.png',
                    width: screenWidth,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 280,
                    left: 63,
                  ),
                  child: Image.asset(
                    'assets/images/splash_flower.png',
                    width: 246,
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
