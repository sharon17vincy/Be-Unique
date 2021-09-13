import 'package:be_unique/BeUnique.dart';
import 'package:be_unique/BioPage.dart';
import 'package:be_unique/Helpers/DataClass.dart';
import 'package:be_unique/Objects/Interests.dart';
import 'package:be_unique/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SelectionView extends StatefulWidget {

  @override
  _SelectionViewState createState() => _SelectionViewState();
}

class _SelectionViewState extends State<SelectionView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  List<Interests> interests = [];
  final BeUnique buMem = BeUnique.getInstance();
  late double _scale;
  late AnimationController controller;


  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.forward(from: 0);
    interests = [];
    interests.addAll(buMem.interestList);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void _tapDown(TapDownDetails details) {
    controller.forward();
  }
  void _tapUp(TapUpDetails details) {
    controller.reverse();
  }


  void showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, ),
            // fontFamily: FontNameDefault),
      ),
      backgroundColor: Colors.black,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.green,
        disabledTextColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    _scale = 1 - controller.value;
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.2), Colors.black)],
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        ),
        ),
        child: Column(
          children: [
            SizedBox(height: 70,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap : (){
                      SystemNavigator.pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 25, )),
                  SizedBox(width: MediaQuery.of(context).size.width/3),
                  Text("PASSIONS",style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: 50,),
            Text("WHAT ARE YOU INTO?",style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
            SizedBox(height: 25,),
            Text("Pick at least 5",style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 25,),
            interests.isNotEmpty ? buildWallLayout() : Container(),
            SizedBox(height: 75,),
            GestureDetector(
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            child: Transform.scale(
            scale: _scale,
            child:_submitButton()))
          ],
        ),),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
        onTap: (){
          if(buMem.interests.length < 5)
          {
            showSnackBar("Pick atleast 5 interests of your choice!");
          }
          else
          {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BioPage()));
          }

        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xff4B6FFF), Color(0xff0226B2)])),
            child: Text(
              'Register Now',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ));
  }


  Widget buildWallLayout() {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.only(left:16, right:16, top: 16.0),
          child: new StaggeredGridView.countBuilder(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 4,
            itemCount: interests.length,
            itemBuilder: (BuildContext context, int index) => __buildStoneChild( interests[index], text: interests[index].name!, image: interests[index].image!),
            staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(getWidth(interests[index].name!), getHeight(interests[index].name!)),
            // mainAxisSpacing: 4.0,
            // crossAxisSpacing: 4.0,
          ),
        ),
      ),
    );
  }


  int getWidth(String name)
  {
    int width = 1;
    if(name.length > 5 && name.length < 10)
    {
      width = 1;
    }
    else if(name.length > 10)
    {
      width = 2;
    }
    return width;
  }

  double getHeight(String name)
  {
    double height = 1;
    if(name.length > 5 && name.length < 10)
    {
      height = 1.5;
    }
    else if(name.length > 10)
    {
      height = 1.5;
    }
    return  height;
  }

  double getVal(String name)
  {
    int width = 1;
    int height = 1;
    if(name.length > 5 && name.length < 10)
    {
      width = 2;
      height = 1;
    }
    else if(name.length > 10)
    {
      width = 2;
      height = 2;
    }
    return (width * height).toDouble();
  }

  Widget __buildStoneChild(Interests interest, {required String text,required String image,} ) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(buMem.interests.contains(interest))
          {
            buMem.interests.remove(interest);
          }
          else
          {
            buMem.interests.add(interest);
          }
          print(buMem.interests.length);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            colorFilter: buMem.interests.contains(interest) ?  new ColorFilter.mode(Colors.blue.withOpacity(0.5), BlendMode.dstATop)
                : new ColorFilter.mode(Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
            image: NetworkImage("https://api.zipconnect.app/img/interests/" + image ),
            fit: BoxFit.contain,
          ),
          gradient: LinearGradient(
            colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.4), Colors.black)],
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
          ),
          // borderRadius: BorderRadius.circular(100),
        ),
        child: Text(text, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: FontNameDefault)),
      ),
      ),
    );
  }
}