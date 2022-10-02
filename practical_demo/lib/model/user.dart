import 'dart:typed_data';

class User {
  int id;
  String name;
  String maths;
  String english;
  String gujarati;
  String picture;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name;
    mapping['maths'] = maths;
    mapping['english'] = english;
    mapping['gujarati'] = gujarati;
    mapping['picture']  =picture;

    return mapping;
  }
}
