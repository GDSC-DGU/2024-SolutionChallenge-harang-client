import 'package:flutter/material.dart';
import 'package:harang_client/style/color_styles.dart';
import 'package:harang_client/type/category_type.dart';
import 'package:harang_client/type/gender_type.dart';
import 'package:harang_client/viewModels/creation_view_model.dart';
import 'package:harang_client/widgets/close_app_bar_widget.dart';
import 'package:harang_client/widgets/age_bottom_sheet_widget.dart';
import 'package:harang_client/widgets/custom_harang_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Author: Daeun
// 도움 생성(글 작성) 관련 뷰 (UI 위젯 분리 거의 안함, 희망 위치 제외 구현 완)

class CreationScreen extends StatefulWidget {
  const CreationScreen({super.key});

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  late CreationViewModel creationViewModel;

// 선호 나이대 바텀시트 띄우기
  void _showAgeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AgeBottomSheetWidget(
          onSelectAge: (selectedAge) {
            creationViewModel.setAge(selectedAge);
          },
        );
      },
    );
  }

// DatePicker 띄우기 및 날짜 반환
  Future<DateTime?> _selectDate(
      BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return picked;
  }

// TODO: 날짜 관련 로직 차후에 수정해야함
// 시작 날짜 선택
  // 시작 날짜 선택
  Future<void> _chooseStartDate() async {
    DateTime initialDate = creationViewModel.startDate != null
        ? DateFormat('yyyy-MM-dd').parse(creationViewModel.startDate!)
        : DateTime.now();
    final DateTime? pickedDate = await _selectDate(context, initialDate);
    if (pickedDate != null) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        creationViewModel.setStartDate(formattedDate); // 시작 날짜 설정
      });
    }
  }

// 끝 날짜 선택
  Future<void> _chooseEndDate() async {
    DateTime initialDate = creationViewModel.endDate != null
        ? DateFormat('yyyy-MM-dd').parse(creationViewModel.endDate!)
        : DateTime.now();
    final DateTime? pickedDate = await _selectDate(context, initialDate);
    if (pickedDate != null) {
      setState(() {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        creationViewModel.setEndDate(formattedDate); // 시작 날짜 설정
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    creationViewModel = Provider.of<CreationViewModel>(context);
    return Scaffold(
      appBar: const CloseAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목
                    const Text(
                      "제목",
                      textAlign: TextAlign.start,
                      // TODO 차후에 title 스타일 관련해서 만들기
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    // TODO 텍스트 필드 위젯으로 빼는거 고민
                    TextField(
                      onChanged: (value) {
                        creationViewModel.setTitle(value);
                      },
                      cursorColor: ColorStyles.main1,
                      decoration: const InputDecoration(
                        hintText: '제목',
                        hintStyle: TextStyle(color: ColorStyles.grey1),
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: ColorStyles.grey1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: ColorStyles.main1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // 카테고리
                    const Text(
                      "카테고리 (최대 3개)",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: HelpCategory.values.map((category) {
                        return ChoiceChip(
                          selectedColor: ColorStyles.main1,
                          label: Text(
                            category.categoryName,
                            style: TextStyle(
                                color: creationViewModel.categories
                                        .contains(category.categoryName)
                                    ? ColorStyles.white
                                    : ColorStyles.grey1),
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: ColorStyles.grey1)),
                          selected: creationViewModel.categories
                              .contains(category.categoryName),
                          onSelected: (bool selected) {
                            creationViewModel.setCategories(selected, category);
                          },
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),

                    // 내용
                    const Text(
                      "내용",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 160,
                      child: TextField(
                        onChanged: (value) {
                          creationViewModel.setContent(value);
                        },
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        cursorColor: ColorStyles.main1,
                        decoration: const InputDecoration(
                          hintText: '세부 내용을 입력해주세요',
                          hintStyle: TextStyle(color: ColorStyles.grey1),
                          contentPadding: EdgeInsets.all(16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: ColorStyles.grey1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: ColorStyles.main1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // 오픈 채팅방 링크
                    const Text(
                      "오픈채팅방 링크",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (value) {
                        creationViewModel.setOpenChatting(value);
                      },
                      cursorColor: ColorStyles.main1,
                      decoration: const InputDecoration(
                        hintText: '1:1 채팅방 링크',
                        hintStyle: TextStyle(color: ColorStyles.grey1),
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: ColorStyles.grey1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: ColorStyles.main1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // 위치
                    const Text(
                      "희망 위치 (선택사항)",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorStyles.grey1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text(
                        '위치 추가',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorStyles.grey1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 성별
                    const Text(
                      "선호 성별 (선택사항)",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: Gender.values.map((gender) {
                        bool isSelected =
                            creationViewModel.gender == gender.genderString;
                        return ChoiceChip(
                          selectedColor: ColorStyles.main1,
                          label: Text(
                            gender.genderString,
                            style: TextStyle(
                                color: creationViewModel.gender ==
                                        gender.genderString
                                    ? ColorStyles.white
                                    : ColorStyles.grey1),
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: ColorStyles.grey1)),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            creationViewModel
                                .setGender(selected ? gender : null);
                          },
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),

                    // 선호 나이대
                    const Text(
                      "선호 나이대 (선택사항)",
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => _showAgeBottomSheet(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorStyles.grey1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          creationViewModel.age ?? '나이대를 선택해주세요',
                          style: TextStyle(
                            fontSize: 16,
                            color: creationViewModel.age == null
                                ? ColorStyles.grey1
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 선호 날짜
                    const Text(
                      "선호 날짜 (선택사항)",
                      style: TextStyle(fontSize: 16, color: ColorStyles.black),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // 선호 날짜 - 시작
                        Expanded(
                          child: InkWell(
                            onTap: _chooseStartDate,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorStyles.grey1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                (creationViewModel.startDate ??
                                        "${DateTime.now().toLocal()}"
                                            .split(' ')[0])
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: creationViewModel.startDate == null
                                      ? ColorStyles.grey1
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // 선호 날짜 - 종료
                        Expanded(
                          child: InkWell(
                            onTap: _chooseEndDate,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorStyles.grey1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text(
                                (creationViewModel.endDate ??
                                        "${DateTime.now().toLocal()}"
                                            .split(' ')[0])
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: creationViewModel.endDate == null
                                      ? ColorStyles.grey1
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: CustomHarangButton(
              isEnabled: creationViewModel.isButtonEnabled,
              onPressed: () {
                // TODO: api 통신 및 페이지 이동
              },
              enabledText: "선택",
              disabledText: "작성완료",
            ),
          ),
        ],
      ),
    );
  }
}
