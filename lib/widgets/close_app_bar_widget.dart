import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';

// Author: Daeun
// 닫기(X) 버튼이 있는 앱바

class CloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CloseAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: ColorStyles.white,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
