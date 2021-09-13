import 'package:be_unique/BeUnique.dart';
import 'package:be_unique/Helpers/DataClass.dart';
import 'package:be_unique/SelectionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  final BeUnique buMem = BeUnique.getInstance();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

   getData();
  }

  Future<bool> getData() async {
    await Helper()
        .getData(context)
        .then((data) async {
      setState(() {
        buMem.interestList.clear();
        buMem.interestList.addAll(data);
        print(buMem.interestList.length);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SelectionView()));
      });
    }).catchError((error) async {
      print("*************************");
      print(error);
      showSnackBar(error);
    });
    return true;
  }

  initScreen(BuildContext context) {
    return Scaffold(
        backgroundColor: appTheme.canvasColor,
        key: _scaffoldKey,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF4B6FFF), Color.alphaBlend(Color(0xFF0226B2).withOpacity(0.4), Colors.black)],
                  )),
          child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  width: 350.0),
              Padding(padding: EdgeInsets.only(top: 40.0)),
              // SpinKitDoubleBounce(color: Theme.of(context).textSelectionColor),
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                ),
            ],
          )),
        ));
  }

  void showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'View',
        textColor: appTheme.primaryColor,
        disabledTextColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}
