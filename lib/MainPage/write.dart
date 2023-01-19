import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mobi_tod0_app_with_firebase/MainPage/FirstPage.dart';
import 'package:mobi_tod0_app_with_firebase/config.dart';
import 'package:date_time_format/date_time_format.dart';

class write extends StatefulWidget {
  final bool tapped;
  final String? jsontitle;
  final Box Taskbox;
  final String task;
  final int index;
  write(this.tapped, this.jsontitle, this.Taskbox, this.task, this.index);
  @override
  _writeState createState() => _writeState();
}

class _writeState extends State<write> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String title = "";
  Color titlecolor = Colors.grey;
  String Note = "";
  final dateTime = DateTime.now();
  void popupTitle() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text("Title"),
              content: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontFamily: "BreeSerif-Regular"),
                    decoration: InputDecoration(hintText: "Title Here"),
                    maxLength: 25,
                    autofocus: true,
                    validator: (_val) {
                      if (_val!.isEmpty) {
                        return "Title Can't be empty !";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (_val) {
                      titlecolor = Color.fromRGBO(143, 148, 251, 1);
                      title = _val;
                    },
                  ),
                ),
              ),
              actions: [
                // ignore: deprecated_member_use
                MaterialButton(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.lightBlue,
                  splashColor: Colors.blue,
                  child: Text("Ok", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (title.isEmpty) {
                      return;
                    } else {
                      Navigator.pop(context);
                    }
                  },
                )
              ]);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.tapped ? widget.jsontitle.toString() : "No title";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor[0][colorindex],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Write note"),
        actions: [
          IconButton(
              onPressed: () {
                Map data = {"Date": dateTime, "Title": title, "Task": Note};
                addNotes(widget.Taskbox, data, widget.tapped, widget.index);
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.save,
                color: Colors.white,
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * .06,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .84,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: MediaQuery.of(context).size.width * 1,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                dateTime.format('l, F j, Y'),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: themecolor[0][colorindex],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //title container
                      InkWell(
                        onTap: () => popupTitle(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.width * 1,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      title,
                                      style: widget.tapped
                                          ? TextStyle(fontSize: 20, color: themecolor[0][colorindex])
                                          : TextStyle(fontSize: 20, color: titlecolor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .62,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                textCapitalization: TextCapitalization.sentences,
                                maxLines: 20,
                                style: TextStyle(fontSize: 22, color: themecolor[0][colorindex]),
                                decoration: InputDecoration(
                                  hintText: widget.tapped ? "" : "Start Typing Here...",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                initialValue: widget.task.toString(),
                                onChanged: (_val) {
                                  Note = _val;
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void addNotes(Box box, Map data, bool isupdate, int index) {
  if (isupdate) {
    box.putAt(index, data);
  } else {
    box.add(data);
  }
}
