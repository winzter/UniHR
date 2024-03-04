import 'package:flutter/material.dart';

class NavIndex with ChangeNotifier {
  int _currentIndex = 0;
  PageController controller = PageController();
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}