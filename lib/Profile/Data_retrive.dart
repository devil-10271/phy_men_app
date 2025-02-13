


import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier{
  String? _profilePictureUrl;
  String? _name;
  String? _email;
  String? get profilePictureUrl => _profilePictureUrl;
  String? get name => _name;
  String? get email => _email;
  void setProfileData(String url, String name, String email)
  {
    _profilePictureUrl = url;
    _name = name;
    _email = email;
    notifyListeners();
  }
}