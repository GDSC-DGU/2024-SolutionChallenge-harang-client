import 'package:flutter/material.dart';

// Author: Daeun
// 선호 나이대 바텀시트 위젯

class AgeBottomSheetWidget extends StatelessWidget {
  final Function(String) onSelectAge;

  const AgeBottomSheetWidget({Key? key, required this.onSelectAge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 나이대 리스트
    final List<String> ageRanges = [
      '20대',
      '30대',
      '40대',
      '50대',
      '60대',
      '70대',
      '80대',
      '선택 안함'
    ];

    return Container(
      height: 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "선호 나이대",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ageRanges.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Text(
                      ageRanges[index],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onTap: () {
                    onSelectAge(ageRanges[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
