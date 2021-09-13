import 'dart:math';

import 'package:be_unique/Theme.dart';
import 'package:flutter/material.dart';

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu> {

  List<int> data = [1,2,3,4,5,6,7,8];

  double radius =  125.0;

  List<Widget> list(){
    final double firstItemAngle = pi;
    final double lastItemAngle = pi;
    final double angleDiff = (firstItemAngle + lastItemAngle) / 6;
    double currentAngle = firstItemAngle;

    return data.map((int index){
      currentAngle += angleDiff;
      return _radialListItem(currentAngle,index);
    }).toList();
  }

  Widget _radialListItem(double angle, int index){

    final x = cos(angle)  * radius;
    final y = sin(angle) * radius;


    return Center(
      child: Transform(
          transform: index == 1 ? Matrix4.translationValues(0.0, 0.0 , 0.0) : Matrix4.translationValues(x, y , 0.0),
          child: InkWell(
            onTap: (){
              print(index.toString());
            },
            child: CircleAvatar(
              radius: 50.0,
              child: Text("Interest"),
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Stack(
            children: list()
        ),
      ),
    );
  }
}