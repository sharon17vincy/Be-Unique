import 'package:be_unique/Objects/Interests.dart';

class Bio
{
  String? name;
  String? profile_picture;
  String? gender;
  int? age;
  String? bio;
  String? add;
  bool? is_dating;
  List<Interests?> interests = [];
  int? inst;
  String? job_title;
  List<String?> photos = [];

  Bio(String name,
    String profile_picture,
    String gender,
    int age,
    String bio,
    String add,
    bool is_dating,
    List<Interests> interests,
      int inst,
      String job_title,
      List<String> photos
  ){
    this.name = name;
    this.profile_picture = profile_picture;
    this.age = age;
    this.gender = gender;
    this.bio = bio;
    this.add = add;
    this.is_dating = is_dating;
    this.interests = interests;
    this.inst = inst;
    this.job_title = job_title;
    this.photos = photos;

  }

  Bio.fromJson(Map json)
      : name = json["name"] ?? "",
        profile_picture = json['profile_picture'] ?? "",
        gender = json['gender'] ?? "",
        age = json['age'] ?? 0,
        is_dating = json['is_dating'] ?? false,
        bio = json['bio'] ?? "",
        job_title = json['job_title'] ?? "-";
}
