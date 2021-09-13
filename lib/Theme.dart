import 'package:be_unique/style.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = new ThemeData(
  primaryColor: Color(0xFF4B6FFF),
  primaryColorDark: Color(0xFF0226B2),
  accentColor: Color(0xFF7959A4),
  brightness: Brightness.light,
  textTheme: TextTheme(bodyText2: Body1Style),
);

const textColor = const Color(0xFF274992);
const ddSelectColor = const Color(0xFF2884C4);
Color primaryHalf = Colors.lightBlue[200]!;
Color colorPrimary = Colors.lightBlue;
const borderColor = const Color(0xFFF1F1F1);
const shadowColor = const Color(0xFFF1F1F1);
const backgroundColor = const Color(0xFFDEEDFF);

TextStyle titleStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontFamily: FontNameDefault,
);

TextStyle appbarTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);

TextStyle appbarSubTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: FontNameDefault,
);

TextStyle normalStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontFamily: FontNameDefault,
);

TextStyle normalBoldStyle = TextStyle(
  color: const Color(0xFF081B3E),
  fontSize: 16,
  fontWeight: FontWeight.w700,
  fontFamily: FontNameDefault,
);

TextStyle normalTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontFamily: FontNameDefault,
);

TextStyle nameStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,//20
  fontWeight: FontWeight.w600,
  fontFamily: FontNameDefault,
);

TextStyle messageStyle = TextStyle(
  color: Color(0xFF8D8D8D),
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);

TextStyle messageStyleGrey = TextStyle(
  color: Color(0xFF8D8D8D),
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);

TextStyle messageStyleBlack = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);


TextStyle headerStyle = TextStyle(
  color: Color(0xFF20252F),
  fontSize: 16,//18
  fontWeight: FontWeight.w600,
  fontFamily: FontNameDefault,
);

TextStyle headingStyle = TextStyle(
  color: Color(0xFF17244F),
  fontSize: 16,//18
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);

TextStyle buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: FontNameDefault,
);

TextStyle galleryGroupHeading = TextStyle(
    color: appTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.w600);
TextStyle galleryGroupSubHeading = TextStyle(
    color: appTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.w600);
TextStyle galleryTitle =
TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle orderDetailHeading = TextStyle(
    color: appTheme.primaryColor, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle orderDetailField =
TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal);

TextStyle orderDetailValue =
TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal);

TextStyle filterCardTitle =
TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);

TextStyle filterCardAction =
TextStyle(color: appTheme.primaryColor, fontSize: 18, fontWeight: FontWeight.w500);

TextStyle gallerySubTitle = TextStyle(
    color: appTheme.primaryColor, fontSize: 14, fontWeight: FontWeight.w500);



ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(appTheme.primaryColor),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  elevation: MaterialStateProperty.all(5),
);

ButtonStyle appBarButtons = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(2, 2, 2, 2)));
