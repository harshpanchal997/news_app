import 'package:flutter/cupertino.dart';

class NewsDetailProvider extends ChangeNotifier {

  int newsIndex = 0;

  ///Clear Provider Data
  void clearProviderData() {
    newsIndex = 0;
  }

  ///Update News Index
  void updateNewsIndex(int index) {
    newsIndex = index;
    notifyListeners();
  }

}