class Interests
{
  String? name;
  String? image;

  Interests(String name, String img){
    {
      this.name = name;
    this.image = img;
  }
  }

  Interests.fromJson(Map json)
      : name = json["name"] ?? "",
        image = json['image'];
}
