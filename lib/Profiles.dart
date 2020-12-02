import 'dart:convert';

import 'package:JustChat/Animation/animation.dart';
import 'package:JustChat/staticVars.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_text/animated_text.dart';
import 'package:animations/animations.dart';
import 'package:bottom_personalized_dot_bar/bottom_personalized_dot_bar.dart';
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

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

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
        /*bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [FontAwesome.user, FontAwesome.home, FlutterIcons.setting_ant],
          activeIndex: 1,
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 0,
          onTap: (index) {},
          height: 65,
          //other params
        ),*/
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

  Future uploadProfilePic123(File file) async {
    String filename = "${staticVars.name}" + "-Pic.jpg";
    var firebaseStorageReference =
        FirebaseStorage.instance.ref().child("ProfilePic/$filename");
    var uploadTask;
    uploadTask = firebaseStorageReference.putFile(file);

    var taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) => print("Done => $value"));
  }

  Future uploadProfilePic(BuildContext context, File file) async {
    String fileName = basename(file.path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    var uploadTask;
    uploadTask = firebaseStorageRef.putFile(file);

    var taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }

  /*Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }*/

  @override
  Widget build(BuildContext context) {
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

    var profileBody = SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
          ],
        ),
      ),
    );

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
                          child: Image.file(
                            staticVars.file,
                            fit: BoxFit.fill,
                            height: 240,
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

                          await uploadProfilePic(context, staticVars.file);
                          setState(() {
                            isCreated = false;
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              body: profileBody,
                            );
                          }));
                        } else {
                          //
                        }
                      } catch (e) {
                        print(e);
                        //AppToast("Cannot create Profile");
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
