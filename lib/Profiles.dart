import 'dart:convert';
//import 'package:firebase/firebase.dart' as fb;
import 'package:JustChat/Animation/animation.dart';
import 'package:JustChat/chat.dart';
import 'package:JustChat/chat.dart';
import 'package:JustChat/staticVars.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_text/animated_text.dart';
import 'package:animations/animations.dart';
import 'package:bottom_personalized_dot_bar/bottom_personalized_dot_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

import 'package:path/path.dart' as Path;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    var createProfileBody = createProfile();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: createProfileBody,
      ),
    );
  }
}

class createProfile extends StatefulWidget {
  @override
  _createProfileState createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {
  DateTime selectedDate;
  final ImagePicker file = ImagePicker();
  bool isCreated = false;

  File image;

  var URL;

  Future imageRetrieve() async {
    var retrieved = await staticVars.fsconnect
        .collection("user")
        .doc("Profiles")
        .collection("${staticVars.username}")
        .doc("${staticVars.username}-Profile")
        .get();

    print(retrieved.data());

    setState(() {
      staticVars.temp1 = retrieved.data();
    });

    print("RETRIEVED : ${staticVars.temp['ProfilePic']}");
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

    Future getImage(ImgSource source) async {
      var imageSelected = await ImagePickerGC.pickImage(
        source: source,
        context: context,
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
      );
      setState(() {
        image = imageSelected;
      });
    }

    Future uploadProfilePic(var file, var username, var mail) async {
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('ProfilePic/$username/${Path.basename(file.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(file);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) async {
        setState(() {
          staticVars.url = fileURL;
          URL = fileURL;
          print(
              "\n################################################\nIMAGE URL = ${staticVars.url} \n##############################################");
        });
        await staticVars.fsconnect
            .collection("user")
            .doc("Profiles")
            .collection("$mail")
            .doc("$mail-Profile")
            .update(
          {
            "ProfilePic": "$fileURL",
          },
        );

        await staticVars.fsconnect
            .collection("user")
            .doc("ids")
            .collection("user-ids")
            .doc("$mail")
            .update({"pic": "$fileURL"});
      });
    }

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 20, top: 20),
              height: 80,
              child: Row(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Create ",
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 35,
                            fontWeight: FontWeight.w900),
                      )),
                  FadeAnimation(
                      1.5,
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 35,
                            fontWeight: FontWeight.w900),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                      bottomRight: Radius.circular(45)),
                  color: Colors.grey.shade100,
                ),
                height: 250,
                width: 300,
                alignment: Alignment.center,
                child: staticVars.file == null
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 25, bottom: 20),
                        child: IconButton(
                            icon: Icon(
                              FlutterIcons.image_plus_mco,
                              size: 60,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () async {
                              await getImage(ImgSource.Gallery);
                              setState(() {
                                staticVars.file = image;
                              });
                            }),
                      )
                    : Container(
                        child: RaisedButton(
                          color: Colors.grey.shade100,
                          elevation: 0,
                          disabledColor: Colors.grey.shade100,
                          focusColor: Colors.grey.shade100,
                          hoverColor: Colors.grey.shade100,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45),
                                  bottomRight: Radius.circular(45)),
                              color: Colors.grey.shade100,
                            ),
                            height: 250,
                            width: 300,
                            child: Image.file(
                              staticVars.file,
                              fit: BoxFit.cover,
                              height: 240,
                            ),
                          ),
                          onPressed: () async {
                            await getImage(ImgSource.Gallery);
                            setState(() {
                              if (image != null) staticVars.file = image;
                            });
                          },
                        ),
                      )),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 55, top: 0),
              child: Text(
                "Name",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              height: 55,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.text,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Colors.blue.shade900, width: 1.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5)),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey.shade500,
                    size: 27,
                  ),
                ),
                onChanged: (value) {
                  staticVars.name = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 55, top: 0),
              child: Text(
                "DOB",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              height: 60,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: DateTimeField(
                selectedDate: selectedDate,
                onDateSelected: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                    staticVars.dob = date;
                  });
                },
                lastDate: DateTime(2020),
                textStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                mode: DateFieldPickerMode.date,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5)),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey.shade500,
                    size: 27,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                //color: Colors.black,
                margin: EdgeInsets.only(top: 25, bottom: 0),
                height: 60,
                width: 300,
                child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    isExtended: true,
                    //backgroundColor: Colors.black,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            //color: Colors.deepPurpleAccent.shade200
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.redAccent.shade200,
                                  Colors.redAccent.shade700
                                ])),
                        height: 75,
                        width: 300,
                        //color: Colors.white,
                        child: Center(
                            child: Text(
                          "Create",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15),
                        ))),
                    onPressed: () async {
                      setState(() {
                        isCreated = true;
                      });

                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MyChat();
                      }));*/

                      try {
                        var retrieved = await staticVars.fsconnect
                            .collection("user")
                            .doc("Profiles")
                            .collection("${staticVars.username}")
                            .doc("${staticVars.username}-Profile")
                            .get();

                        print(retrieved.data());
                        staticVars.temp = retrieved.data();
                        var temp = staticVars.temp;

                        if (temp["ProfileName"] == null ||
                            temp["ProfileDOB"] == null) {
                          print(
                              "#######################################################\n");
                          print("URL1 = ${staticVars.url}\n");
                          print("URL2 = $URL");
                          print(
                              "####################################################");

                          await staticVars.fsconnect
                              .collection("user")
                              .doc("Profiles")
                              .collection("${staticVars.username}")
                              .doc("${staticVars.username}-Profile")
                              .update(
                            {
                              //###########################

                              //#######################
                              "ProfileName": staticVars.name,
                              //"ProfilePic": "${staticVars.url}",
                              "ProfileDOB": "${staticVars.dob}",
                            },
                          );

                          await uploadProfilePic(staticVars.file,
                              staticVars.name, staticVars.username);

                          await staticVars.fsconnect
                              .collection("user")
                              .doc("ids")
                              .collection("user-ids")
                              .doc("${staticVars.username}")
                              .update({
                            "name": staticVars.name,
                            "mail": staticVars.username
                          });

                          var r = staticVars.fsconnect
                              .collection("user")
                              .doc("ids")
                              .collection("user-ids");

                          var documents = await r.get();
                          var docLen = documents.docs.length;

                          List<DocumentSnapshot> docs = documents.docs;
                          int k = 0;
                          /*for (var i in docs) {
                            if (i['name'] == staticVars.name) {
                              print(docs[k]['name']);
                              docs.removeAt(k);
                              print("DONE REMOVING");
                              //docLen--;
                              //print("LENGTH REDUCED");
                            }
                            k++;
                            print(k);
                          }*/
                          setState(() {
                            staticVars.doclen = docLen;
                            staticVars.docs = docs;
                          });

                          //profile pic

                          //print("IMAGE = ${temp['ProfilePic']}");

                          print("RETRIEVING IMAGE ******************");

                          await imageRetrieve();

                          print("DONE*********************************");

                          setState(() {
                            isCreated = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SelectProfile();
                          }));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SelectProfile();
                          }));
                          //
                        }
                      } catch (e) {
                        print(e);
                      }
                      /*
                      try {
                        if (staticVars.name != null &&
                            staticVars.file != null &&
                            staticVars.dob != null) {
                          await staticVars.fsconnect
                              .collection("user")
                              .doc(staticVars.authc.currentUser.uid)
                              .set(
                            {
                              //###########################
                              //ERROR HERE
                              //#######################
                              "ProfileName": staticVars.name,
                              //"ProfilePic": staticVars.file,
                              "ProfileDOB": staticVars.dob,
                            },
                          );

                          //await uploadProfilePic(context, staticVars.file);
                          await uploadProfilePic(staticVars.file);
                          setState(() {
                            isCreated = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SelectProfile();
                          }));
                        } else {
                          //
                        }
                      } catch (e) {
                        print(e);
                        //AppToast("Cannot create Profile");
                      }

                      */
                    }))
          ],
        ),
      ),
    );
  }
}

class SelectProfile extends StatefulWidget {
  @override
  _SelectProfileState createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //await profileSelect();
    print(staticVars.doclen);
  }

  Future profileSelect() async {
    var r = await staticVars.fsconnect
        .collection("user")
        .doc("ids")
        .collection("user-ids");

    var documents = await r.get();
    var docLen = documents.docs.length;

    List<DocumentSnapshot> docs = documents.docs;

    setState(() {
      staticVars.doclen = docLen;
    });

    //print("RETRIEVED : ${staticVars.temp['ProfilePic']}");
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

    //imageRetrieve();

    var profileBody = SingleChildScrollView(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            //separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20, top: 20),
                  height: 80,
                  child: Container(
                      child: FadeAnimation(
                          1,
                          Text(
                            "Profiles",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          )))),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: staticVars.doclen,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Center(
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                height: 70,
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.only(left: 45),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.shade400,
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width - 75,
                                child: RaisedButton(
                                  color: Colors.redAccent.shade400,
                                  elevation: 0,
                                  onPressed: () async {
                                    staticVars.id =
                                        await staticVars.docs[index]['id'];

                                    print(staticVars.id);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MyChat();
                                    }));
                                  },
                                  child: Center(
                                    child: Text(
                                      "${staticVars.docs[index]['name']}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                //bottom: 20,
                                height: 90,
                                width: 90,
                                child: Container(
                                  //margin: EdgeInsets.only(top: 0, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(
                                          width: 8, color: Colors.white),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              staticVars.docs[index]['pic']))),
                                  alignment: Alignment.topCenter,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        )
                      ],
                    );
                  }),
            ],
          )

          /*Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20, top: 20),
                height: 80,
                child: Container(
                    child: FadeAnimation(
                        1,
                        Text(
                          "Profiles",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 35,
                              fontWeight: FontWeight.w900),
                        )))),
            /*ListView.builder(
              itemBuilder: (BuildContext context, int n) {
                return ListView();
              },
              itemCount: 2,
            )*/
          ],
        ),*/
          ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: profileBody,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                FlutterIcons.menu_ent,
                color: Colors.blue.shade900,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.blue.shade900,
                  size: 30,
                ),
                onPressed: null),
            Container(
              height: 1,
              width: 55,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.grey.shade300,
                      width: 5,
                      style: BorderStyle.solid),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(staticVars.temp1["ProfilePic"]))),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
