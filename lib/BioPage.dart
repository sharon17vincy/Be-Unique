import 'dart:math';
import 'dart:ui';
import 'package:be_unique/Helpers/BioClass.dart';
import 'package:be_unique/Objects/Bio.dart';
import 'package:be_unique/Objects/Interests.dart';
import 'package:be_unique/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BioPage extends StatefulWidget {

  @override
  _BioPageState createState() => _BioPageState();
}

class _BioPageState extends State<BioPage> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int imageIdx = 0;
  String swipeDirection = "";
  List<String> images = [];
  List<int> data = [1,2,3,4,5,6,7,8];
  List<Interests> interests = [];
  double radius =  125.0;
  Bio bio = new Bio("", "", "", 0, "", "", false, [], 0, "", []);
  late Future _future;
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
    swipeDirection = "";
    setState(() {
      imageIdx = 0;
    });
    interests = [];
    _scale = 1 - controller.value;
    _future = getData();
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


  Future<bool> getData() async {
    await BioHelper()
        .getBio(context)
        .then((data) async {
      setState(() {
        bio = data;
        print(bio.interests.length);

        images.clear();
        images.add(bio.profile_picture!);
        images.add(bio.profile_picture!);
      });
    }).catchError((error) async {
      print("*************************");
      print(error);
      showSnackBar(error);
    });
    return true;
  }


  void showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
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
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (_, snapshot) {
      if (snapshot.connectionState != ConnectionState.waiting) {
        return SafeArea(
        child: Container(
                    height: double.infinity,
                    child: newGalleryView())
      );
          }
          return Container(
          height: 500,
          child: Center(
          child: CircularProgressIndicator(
          strokeWidth: 3,
          ),
          ),
          );
        }),
    );
  }

  Widget newGalleryView() {
    images.forEach((image) {
      precacheImage(NetworkImage(image), context, onError: (_, __) {});
    });
    return Container(
      child:
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      GestureDetector(
                        onPanUpdate: (details) {
                          swipeDirection =
                          details.delta.dx < 0 ? 'left' : 'right';
                        },
                        onPanEnd: (details) {
                          if ((swipeDirection == "left") &&
                              (imageIdx <
                                  (images.length -
                                      1))) {
                            setState(() {
                              imageIdx += 1;
                            });
                          } else if ((swipeDirection == "right") &&
                              (imageIdx > 0)) {
                            setState(() {
                              imageIdx -= 1;
                            });
                          }
                        },
                        //Full width with dynamic height
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height/1.5),
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                images[imageIdx]),

                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          widthFactor: 1,
                          child: images.length > 1
                              ? _pageIndicator()
                              : Container(),
                        ),
                      ),
                      new Positioned(
                        right: 30.0,
                        bottom: 120,
                        child:Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.9), Colors.black)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.favorite_border, color: Colors.white, size: 25,),
                        ),
                      ),
                      new Positioned(
                          right: 30.0,
                          bottom:50,
                          child:Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.9), Colors.black)],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image(
                              image: AssetImage(
                                'assets/images/dislike.png',),
                              height: 25,
                              width: 25,
                              color: Colors.white,

                            ),)
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.2), Colors.black)],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(bio.name! + ", "  + bio.age!.toString() , style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                        SizedBox(height: 25,),
                        Text(bio.bio!,
                          style: TextStyle(color: Colors.white, fontSize: 14,),),
                        SizedBox(height: 30,),
                        Text("Basic info" ,style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF495896),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.name!, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gender", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.gender!, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Age", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.age!.toString(), textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Location", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.add!, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Personal info" ,style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFF495896),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Looking For", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Relationship status", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.is_dating! ? "Yes" : "No", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Kids", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Work Title", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text(bio.job_title!, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Education", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hair color", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Eye color", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Height", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Ethnicity", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                  color: appTheme.primaryColorDark,),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Religion", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                      Text("-", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,  fontSize: 17.0)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text(bio.inst.toString() + " Instagram Posts" ,style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            // Icon(Icons.chevron_left, size: 25, color: Colors.white,),
                            Container(
                              color: Colors.transparent,
                                height: 105,
                                width: MediaQuery.of(context).size.width/1.2,
                                child:  GridView.count(
                                  scrollDirection: Axis.horizontal,
                                  crossAxisCount: 1,
                                  padding: EdgeInsets.all(4.0),
                                  childAspectRatio: 8.0 / 9.0,
                                  children: bio.photos.map(
                                        (img) => horizontalGroups(img!),).toList(),
                                )
                            ),
                            // Icon(Icons.chevron_right, size: 25, color: Colors.white,),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            // Icon(Icons.chevron_left, size: 25, color: Colors.white,),
                            Container(
                                color: Colors.transparent,
                                height: 105,
                                width: MediaQuery.of(context).size.width/1.2,
                                child:  GridView.count(
                                  scrollDirection: Axis.horizontal,
                                  crossAxisCount: 1,
                                  padding: EdgeInsets.all(4.0),
                                  childAspectRatio: 8.0 / 9.0,
                                  children: bio.photos.map(
                                        (img) => horizontalGroups(img!),).toList(),
                                )
                            ),
                            // Icon(Icons.chevron_right, size: 25, color: Colors.white,),

                          ],
                        ),
                        SizedBox(height: 50,),
                        Text("Passions" ,style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),),
                        SizedBox(height: 20,),
                        Container(
                          height: 300,
                            child: Stack(
                                children: list()),),
                        SizedBox(height: 50,),
                    GestureDetector(
                      onTapDown: _tapDown,
                      onTapUp: _tapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child:
                        _submitButton("REPORT"))),
                    GestureDetector(
                      onTapDown: _tapDown,
                      onTapUp: _tapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child:_submitButton("UNPAIR"))),
                    GestureDetector(
                      onTapDown: _tapDown,
                      onTapUp: _tapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child:_submitButton("BLOCK")))

                      ],
                    ),
                  ),),

              ],
            ),
          ),
    );
  }


  Future<void> custSheet(BuildContext context, int index,) async {
    var interest = "";
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                        )),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text("CANCEL", style: filterCardAction)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                bio.interests.add(Interests(interest, ""));
                              });
                            },
                            child: Text("DONE", style: filterCardAction))
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                        )),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Interests", style: filterCardTitle),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  interest = value;
                                });
                              },

                              decoration: InputDecoration(
                                  labelText: "Type your interest",
                                  hintText: "Type your interest",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }


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
                setState(() {
                  custSheet(context, index);
                });
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              image: DecorationImage(
              image: NetworkImage("https://api.zipconnect.app/img/interests/" + getImage(index)! ),
              fit: BoxFit.contain,
              ),
              gradient: LinearGradient(
              colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.4), Colors.black)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              ),
              // borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(getName(index)!, textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
              ),
          ))
      ),
    );
  }

  String? getName(int idx)
  {
    String name = "Interests";
    if(idx < bio.interests.length)
    {
      name = bio.interests[idx]!.name!;
    }

    return name;
  }

  String? getImage(int idx)
  {
    String name = "";
    if(idx < bio.interests.length)
    {
      name = bio.interests[idx]!.image!;
    }

    return name;
  }


  Widget _submitButton(String s) {
    return GestureDetector(
        onTap: (){
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: s == "REPORT" ? Color(0xFF081C71) : s == "UNPAIR" ? Color(0xFF2699FB) : Color(0xFFDEDEDE),
            borderRadius: BorderRadius.all(Radius.circular(4)),),
            child: Text(
              s,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
        ));
  }

  Widget horizontalGroups(String images,) {
    print("IMAGE : $images");
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 106,
          width: 106,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: NetworkImage(
                      images),
                  fit: BoxFit.cover,
                  // onError: (_, __) {
                  //   return AssetImage('assets/images/arm_logo.png');
                  // }
                  )
          ),
        ),
      ),
    );
  }

  Widget _pageIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      List<Widget>.generate(images.length, (int index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 10,
          width: (imageIdx == index) ? 30 : 10,
          margin: EdgeInsets.symmetric(horizontal: 05, vertical: 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(5),
            color: (imageIdx == index)
                ? Colors.green
                : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }




}
