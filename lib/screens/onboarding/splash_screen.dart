import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/harang_logo.png',
                  width: 100,
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text(
                  '함께 사는 세상 높은 하늘이 되다',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorStyles.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
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
