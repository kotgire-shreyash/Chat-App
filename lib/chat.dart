/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'staticVars.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var msgtextcontroller = TextEditingController();
  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;
  String chatmsg;

  chatidgenrator(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (staticVars.index % 2 == 0) {
      var color = Colors.red;
    } else {
      var color = color;
    }
    FlutterStatusbarcolor.setStatusBarColor(color[shade]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;
    String docid = chatidgenrator(authc.currentUser.uid, staticVars.id);

    Query chat = FirebaseFirestore.instance
        .collection('chat')
        .doc(docid)
        .collection('messages')
        .orderBy('time', descending: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: color[shade],
          elevation: 0,
          title: Text(staticVars.profName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 27)),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [.5, .5],
                colors: [color[shade], Colors.white],
              ),
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: MediaQuery.of(context).size.height - 175,
                  padding: EdgeInsets.only(top: 20),
                  width: deviceWidth,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      builder: (context, snapshot) {
                        print('new msg incoming');

                        var msg = snapshot.data.docs;

                        List<Widget> y = [];
                        for (var d in msg) {
                          var msgText = d.data()['text'];
                          var msgSender = d.data()['sender'];
                          var msgWidget = Text("$msgText");
                          print("MSGSENDER =  = == == $msgSender");
                          //y.add(msgWidget);

                          if (msgSender == staticVars.username) {
                            y.add(Container(
                              decoration: BoxDecoration(
                                  color: color[shade],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(18),
                                      bottomRight: Radius.circular(4))),
                              width: 175,
                              margin: EdgeInsets.only(left: deviceWidth / 2),
                              alignment: Alignment.centerRight,
                              //color: color,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  msgText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ));
                          } else {
                            y.add(Container(
                              decoration: BoxDecoration(
                                  color: color.shade100,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(4))),
                              width: 175,
                              margin: EdgeInsets.only(right: deviceWidth / 2),
                              alignment: Alignment.topLeft,
                              //color: Colors.red,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  msgText,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ));
                          }

                          y.add(SizedBox(
                            height: 20,
                          ));
                        }

                        print("MSG ORDER = $y");

                        return Container(
                          height: MediaQuery.of(context).size.height - 65,
                          width: deviceWidth,
                          child: SingleChildScrollView(
                            child: Column(
                              children: y,
                            ),
                          ),
                        );
                      },
                      stream: chat.snapshots(),
                      /*stream: fs
                          .collection("chat")
                          .doc(docid)
                          .collection("messages")
                          .snapshots(),*/
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //MESSAGE BOX
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 165),
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 15, left: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(35)),
                            alignment: Alignment.centerLeft,
                            width: deviceWidth * 0.75,
                            height: 55,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Colors.grey[shade],
                                  fontWeight: FontWeight.bold),
                              controller: msgtextcontroller,
                              decoration: InputDecoration(
                                hintText: 'Send a message...',
                                hintStyle: TextStyle(
                                    color: Colors.grey[shade], fontSize: 14),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1.5)),
                              ),
                              onChanged: (value) {
                                chatmsg = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 2, bottom: 20),
                            child: FloatingActionButton(
                              elevation: 2,
                              //hoverColor: color[shade],
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, top: 0),
                                  decoration: BoxDecoration(
                                      color: color[shade],
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    FlutterIcons.send_mco,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                msgtextcontroller.clear();

                                await fs
                                    .collection("chat")
                                    .doc(docid)
                                    .collection("messages")
                                    .add({
                                  "text": chatmsg,
                                  "sender": signInUser,
                                  "time": DateTime.now().millisecondsSinceEpoch
                                });

                                print(signInUser);
                              },
                              backgroundColor: color[shade],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'staticVars.dart';

class MyChat extends StatefulWidget {
  @override
  _MyChatState createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  var msgtextcontroller = TextEditingController();
  var fs = FirebaseFirestore.instance;
  var authc = FirebaseAuth.instance;
  String chatmsg;

  chatidgenrator(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    var color, shade, lightshade;
    if (staticVars.index % 2 == 0) {
      color = Colors.redAccent;
      shade = 400;
      lightshade = Colors.red.shade100;
    } else {
      color = Colors.blue;
      shade = 900;
      lightshade = Colors.blue.shade100;
    }
    FlutterStatusbarcolor.setStatusBarColor(color[shade]);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;
    String docid = chatidgenrator(authc.currentUser.uid, staticVars.id);

    Query chat = FirebaseFirestore.instance
        .collection('chat')
        .doc(docid)
        .collection('messages')
        .orderBy('time', descending: false);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 28,
            onPressed: () async {
              await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
              await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
              Navigator.pop(context);
            },
          ),
          backgroundColor: color[shade],
          elevation: 0,
          title: Text(staticVars.profName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 27)),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [.5, .5],
                colors: [color[shade], Colors.white],
              ),
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: MediaQuery.of(context).size.height - 175,
                  padding: EdgeInsets.only(top: 20),
                  width: deviceWidth,
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      builder: (context, snapshot) {
                        print('new msg incoming');

                        var msg = snapshot.data.docs;

                        List<Widget> y = [];
                        for (var d in msg) {
                          var msgText = d.data()['text'];
                          var msgSender = d.data()['sender'];
                          var msgWidget = Text("$msgText");
                          print("MSGSENDER =  = == == $msgSender");
                          //y.add(msgWidget);

                          if (msgSender == staticVars.username) {
                            y.add(Container(
                              decoration: BoxDecoration(
                                  color: color[shade],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(18),
                                      bottomRight: Radius.circular(4))),
                              width: 175,
                              margin: EdgeInsets.only(left: deviceWidth / 2),
                              alignment: Alignment.centerRight,
                              //color: color,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  msgText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ));
                          } else {
                            y.add(Container(
                              decoration: BoxDecoration(
                                  color: lightshade,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(4))),
                              width: 175,
                              margin: EdgeInsets.only(right: deviceWidth / 2),
                              alignment: Alignment.topLeft,
                              //color: Colors.red,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  msgText,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ));
                          }

                          y.add(SizedBox(
                            height: 20,
                          ));
                        }

                        print("MSG ORDER = $y");

                        return Container(
                          height: MediaQuery.of(context).size.height - 65,
                          width: deviceWidth,
                          child: SingleChildScrollView(
                            child: Column(
                              children: y,
                            ),
                          ),
                        );
                      },
                      stream: chat.snapshots(),
                      /*stream: fs
                          .collection("chat")
                          .doc(docid)
                          .collection("messages")
                          .snapshots(),*/
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                //MESSAGE BOX
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 165),
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 15, left: 20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(35)),
                            alignment: Alignment.centerLeft,
                            width: deviceWidth * 0.75,
                            height: 55,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.bold),
                              controller: msgtextcontroller,
                              decoration: InputDecoration(
                                hintText: 'Send a message...',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 14),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200,
                                        width: 2.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1.5)),
                              ),
                              onChanged: (value) {
                                chatmsg = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 2, bottom: 20),
                            child: FloatingActionButton(
                              elevation: 2,
                              //hoverColor: color[shade],
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, top: 0),
                                  decoration: BoxDecoration(
                                      color: color[shade],
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    FlutterIcons.send_mco,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                msgtextcontroller.clear();

                                await fs
                                    .collection("chat")
                                    .doc(docid)
                                    .collection("messages")
                                    .add({
                                  "text": chatmsg,
                                  "sender": signInUser,
                                  "time": DateTime.now().millisecondsSinceEpoch
                                });

                                print(signInUser);
                              },
                              backgroundColor: color[shade],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
