import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';

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
        ],
      ),
    );
  }
}
