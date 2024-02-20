// creation_view_model.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harang_client/type/category_type.dart';
import 'package:harang_client/type/gender_type.dart';

// Author: Daeun
// 도움 생성(글 작성) 관련 뷰모델

class CreationViewModel with ChangeNotifier {
  String _title = "";
  final List<String> _categories = [];
  String _content = "";
  String _openChatting = "";
  String? _gender;
  String? _age;
  String? _startDate; // "yyyy-mm-dd"
  String? _endDate; // "yyyy-mm-dd"

  String get title => _title;
  String get content => _content;
  String get openChatting => _openChatting;
  List<String> get categories => _categories;
  String? get gender => _gender;
  String? get age => _age;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  bool get isButtonEnabled =>
      _title.isNotEmpty &&
      _content.isNotEmpty &&
      _openChatting.isNotEmpty &&
      _categories.isNotEmpty;

  void setTitle(String title) {
    _title = title;
    notifyListeners(); // 변경 내용 전파
  }

  void setContent(String content) {
    _content = content;
    notifyListeners();
  }

  void setOpenChatting(String openChatting) {
    _openChatting = openChatting;
    notifyListeners();
  }

// TODO: 카테고리 아무것도 없을 때 예외처리 필요할까? -> 나중에 버튼 비활성화에 영향
  void setCategories(bool selected, HelpCategory category) {
    if (selected && _categories.length != 3) {
      _categories.add(category.categoryName);
    } else {
      _categories.removeWhere((String name) => name == category.categoryName);
    }
    notifyListeners();
  }

  void setGender(Gender? gender) {
    _gender = gender?.genderString;
    notifyListeners();
  }

// TODO: 현재 null처리 관련해 하드코딩, 나중에 type으로 관리하는 방식으로 수정할 것
  void setAge(String age) {
    if (age == '선택 안함') {
      _age = null;
    } else {
      _age = age;
    }
    notifyListeners();
  }

  void setStartDate(String date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(String date) {
    _endDate = date;
    notifyListeners();
  }
}
