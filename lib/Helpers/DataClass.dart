import 'dart:async';
import 'dart:convert';
import 'package:be_unique/Objects/Interests.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class Helper
{
  Future<List<Interests>> getData(BuildContext context) async
  {
    String url = "https://api.zipconnect.app/api/v1/category/60597fa4eb72561fb6bb064f";

    print(url);

    final response = await http.get(Uri.parse(url),
        headers:
        {
          "Content-Type" : "application/json",
        },
    );

    if (response.statusCode == 200)
    {
      Map<String, dynamic> responseJson = json.decode(response.body);
      print(responseJson['data']);

      List<Interests> interests = [];
      List val = responseJson['data']['interests'];
      for(int i=0; i < val.length; i++)
      {
        interests.add(Interests.fromJson(val[i]));
      }

      print("************Interests");
      print(interests.length);

      return interests;
    }
    else
    {
      print(response.body);
      Map<String, dynamic> responseJson = json.decode(response.body);
      throw responseJson['message'];
    }
  }



}
