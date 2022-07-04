import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier {
  String id = "";
  String token = "";
  String databaseName = "";
  void setData(String ID, String Token) {
    id = ID;
    token = Token;
    notifyListeners();
  }
}
