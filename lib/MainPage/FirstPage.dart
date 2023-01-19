import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mobi_tod0_app_with_firebase/MainPage/write.dart';
import 'package:mobi_tod0_app_with_firebase/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double x = 0;
  double y = 0;
  double scaleFactor = 1;
  bool isdraweropen = false;
  late Box box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openbox();
    setState(() {});
  }

  Future openbox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    box = await Hive.openBox("Tasks").whenComplete(() {
      setState(() {});
    });

    return;
  }

  Widget Tasklist() {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  blurRadius: 2.0,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: box.isNotEmpty
                ? ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => write(
                                  true,
                                  box.get(index)["Title"].toString(),
                                  box,
                                  box.get(index)["Task"].toString(),
                                  box.keyAt(index))));
                    },
                    leading: Icon(FontAwesomeIcons.calendar),
                    title: Text(
                      box.get(index)["Title"].toString().isEmpty
                          ? "empty"
                          : box.get(index)["Title"].toString(),
                      style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                    subtitle: Text(
                      box.get(index)['Task'].toString(),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : Center(
                    child: Text("Add First Task :)"),
                  ));
      },
    );
  }
  //*********************************************************************************** */

  void addTask(DateTime date, String Title, String Note) {
    Map data = {"Date": date, "Title": Title, "Task": Note};

    box.add(date);
  }

  void youtube() async => await canLaunch(
          "https://www.youtube.com/channel/UCGy7l9UwjdfnSCMSDOuC-Xw")
      ? await launch("https://www.youtube.com/channel/UCGy7l9UwjdfnSCMSDOuC-Xw")
      : throw 'Could not load ';
  void instagram() async =>
      await canLaunch("https://www.instagram.com/mobin.shaikh.7186/")
          ? await launch("https://www.instagram.com/mobin.shaikh.7186/")
          : throw 'Could not load ';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent.shade100,
          title: Text(
            "Your Diary Events",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh)),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            write(false, null, box, "", box.length + 1)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                  Text(
                    "New",
                    style: TextStyle(
                        color: Colors.red, fontFamily: "BreeSerif-Regular"),
                  )
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          blurRadius: 10.0,
                          offset: Offset(-5, 3)),
                    ],
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .86,
                  child: Tasklist())),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("abc xyz"),
                accountEmail: Text("xxxxxx@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: Text("X D"),
                  backgroundColor: logoscreen,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.rate_review,
                  color: Colors.blue,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text("Rate and Review",
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ),
              ListTile(
                onTap: youtube,
                leading: Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text(
                  "Subscribe me",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
              ListTile(
                onTap: instagram,
                leading: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.purple,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text("Instagram",
                    style: TextStyle(fontSize: 18, color: Colors.purple)),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.accusoft,
                  color: Colors.indigo,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text("about me!",
                    style: TextStyle(fontSize: 18, color: Colors.indigo)),
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.amber,
                              ),
                              Text(
                                "Warning ! ",
                                style: TextStyle(color: Colors.amber),
                              )
                            ],
                          ),
                          content: Text(
                            "Do you want to delete all Data ?",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                box.clear();
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        );
                      });
                },
                leading: Icon(
                  Icons.delete,
                  color: Colors.cyan,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text("Delete all DATA ",
                    style: TextStyle(fontSize: 18, color: Colors.cyan)),
              ),
              ListTile(
                onTap: () => exit(0),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.deepOrange,
                  size: MediaQuery.of(context).size.width * .086,
                ),
                title: Text("Exit",
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//CRUD fUNCTIONS//
//********************************************************************************************************************** */




