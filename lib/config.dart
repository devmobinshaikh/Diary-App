import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryColor = Color(0xff18203d);
Color secondoryColor = Color(0xff232c51);
Color logoscreen = Color(0xff25bcbb);

String applogo = 'assets/applogo.gif';
String diaryimg = 'assets/diary1.png';

List<Map> themecolor = [
  {
    '1': Color.fromRGBO(193, 0, 178, 1),
    '2': Color.fromRGBO(193, 0, 100, 1),
    '3': Color.fromRGBO(193, 0, 200, 1),
    '4': Color.fromRGBO(245, 0, 178, 1),
    '5': Color.fromRGBO(143, 148, 251, 1),
  }
];

String colorindex = "5";
Color primaryGreen = Color(0xff416d6d);
List<Map> draweritems = [
  {'icon': FontAwesomeIcons.bell, 'title': "Reminder"},
  {'icon': Icons.file_upload_sharp, 'title': "Export"},
  {'icon': Icons.rate_review, 'title': "Rate and Review"},
  {'icon': Icons.youtube_searched_for, 'title': "Subscribe Me"},
  {'icon': Icons.facebook, 'title': "Facebook "},
  {'icon': Icons.help, 'title': "help"},
  {'icon': FontAwesomeIcons.exclamationCircle, 'title': "About"}
];
