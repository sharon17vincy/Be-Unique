import 'dart:async';
import 'dart:convert';
import 'package:be_unique/Objects/Bio.dart';
import 'package:be_unique/Objects/Interests.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class BioHelper
{
  Future<Bio> getBio(BuildContext context) async
  {
    String url = "https://api.zipconnect.app/api/v1/profile/me";

    print(url);
    var id = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwZGM1MThlODJlM2QwMDNjZTc4MmMzMiIsImlhdCI6MTYzMTAzNTkyNywiZXhwIjoxNjM4ODExOTI3fQ.UaEnSaHGIdq89F3KURngkdKJ03PCihJ5ulf09VdlVWI";

    final response = await http.get(Uri.parse(url),
      headers:
      {
        "Content-Type" : "application/json",
        'Authorization': 'Bearer $id'
      },
    );

    if (response.statusCode == 200)
    {
      Map<String, dynamic> responseJson = json.decode(response.body);
      print(responseJson['data']['profile']);
      print(responseJson['data']['profile']['interests']);
      print(responseJson['data']['profile']['media']);
      Bio bio = Bio.fromJson(responseJson['data']['profile']);
      bio.add = responseJson['data']['profile']['location']['address'];


      List<Interests> interests = [];
      List val = responseJson['data']['profile']['interests'];
      for(int i=0; i < val.length; i++)
      {
        print(val[i]);
        interests.add(Interests.fromJson(val[i]));
        bio.interests.add(Interests.fromJson(val[i]));
      }
      print("************Interests");
      print(interests.length);


      List inst = responseJson['data']['profile']['instagram'];
      bio.inst = inst.length;

      List media = responseJson['data']['profile']['media'];
      print("************Media");
      print(media.length);

      List<String> photos = [];
      for(int i=0; i < media.length; i++)
      {
        print(media[i]);
        if(!media[i]['is_video'])
        photos.add(media[i]['filename']);
      }
      print("************Photos");
      print(photos.length);
      bio.photos.clear();
      bio.photos.addAll(photos);

      List<String> videos = [];
      for(int i=0; i < media.length; i++)
      {
        print(media[i]);
        if(media[i]['is_video'])
          videos.add(media[i]['video']);
      }
      print("************Videos");
      print(videos.length);



      return bio;
    }
    else
    {
      print(response.body);
      Map<String, dynamic> responseJson = json.decode(response.body);
      throw responseJson['message'];
    }
  }

}
