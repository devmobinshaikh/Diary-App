import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobi_tod0_app_with_firebase/MainPage/FirstPage.dart';

import 'package:mobi_tod0_app_with_firebase/config.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  double progressValue = 0.0;
  bool _isRunning = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
      if (_isRunning && progressValue < 1.0) {
        setState(() {
          progressValue += 0.01;
        });
      } else {
        _isRunning = false;
        timer.cancel();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 0.6),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                diaryimg,
                width: 200,
                height: 200,
              ),
              decoration: BoxDecoration(
                  color: logoscreen, borderRadius: BorderRadius.circular(500)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              " WELCOME  ! \n\nThis Diary Helps You \n To Remeber Your Past..",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "BreeSerif-Regular"),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height * .05,
                child: LiquidLinearProgressIndicator(
                  value: progressValue, // Defaults to 0.5.
                  valueColor: AlwaysStoppedAnimation(
                    Colors.yellow,
                  ), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors
                      .white, // Defaults to the current Theme's backgroundColor.
                  borderColor: Colors.transparent,
                  borderWidth: 5.0,
                  borderRadius: 12.0,
                  direction: Axis
                      .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                  center: Text(
                    (progressValue * 100).toInt().toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cursive"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
