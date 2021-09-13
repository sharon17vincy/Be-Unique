

import 'package:be_unique/Objects/Interests.dart';

class BeUnique {
  static final BeUnique ourInstance = new BeUnique();

  static BeUnique getInstance() {
    return ourInstance;
  }

  List<Interests> interests = [];
  List<Interests> interestList = [];

  BeUnique() {
    interests = [];
    interestList = [];

  }
}
