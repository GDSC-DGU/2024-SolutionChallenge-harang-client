import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';

class CustomHarangButton extends StatelessWidget {
  final bool isEnabled; // 버튼이 활성화되는 조건
  final VoidCallback? onPressed; // 버튼을 누른 후 실행되는 콜백
  final String enabledText;
  final String disabledText;

  const CustomHarangButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
    required this.enabledText,
    required this.disabledText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: isEnabled ? ColorStyles.main1 : ColorStyles.grey3,
          minimumSize: const Size(double.infinity, 48)),
      child: Text(
        isEnabled ? enabledText : disabledText,
        style: const TextStyle(color: ColorStyles.white),
      ),
    );
  }
}
