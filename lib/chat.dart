import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
    var deviceWidth = MediaQuery.of(context).size.width;
    var signInUser = authc.currentUser.email;
    String docid = chatidgenrator(authc.currentUser.uid, staticVars.id);
    return Scaffold(
        persistentFooterButtons: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(35)),
                      alignment: Alignment.centerLeft,
                      width: deviceWidth * 0.75,
                      height: 65,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold),
                        controller: msgtextcontroller,
                        decoration: InputDecoration(
                          hintText: 'message',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 18),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade100, width: 1.5)),
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
                      margin: EdgeInsets.only(right: 10, left: 2, bottom: 20),
                      child: FloatingActionButton(
                        elevation: 2,
                        //hoverColor: Colors.blue.shade900,
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 5, top: 0),
                            decoration: BoxDecoration(
                                color: Colors.blue.shade900,
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
                              .add({"text": chatmsg, "sender": signInUser});

                          print(signInUser);
                        },
                        backgroundColor: Colors.blue.shade900,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
        appBar: AppBar(
          title: Text('chat'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  builder: (context, snapshot) {
                    print('new msg incoming');

                    var msg = snapshot.data.docs;

                    List<Widget> y = [];
                    for (var d in msg) {
                      var msgText = d.data()['text'];
                      var msgSender = d.data()['sender'];
                      var msgWidget = Text("$msgText");

                      y.add(msgWidget);
                      y.add(SizedBox(
                        height: 20,
                      ));
                    }

                    print(y);

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
                  stream: fs
                      .collection("chat")
                      .doc(docid)
                      .collection("messages")
                      .snapshots(),
                ),
              ],
            ),
          ),
        ));
  }
}
