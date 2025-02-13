import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:phy_men_app/main.dart";
import 'package:basic_utils/basic_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "dart:io";

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  File? image;
  final user = FirebaseAuth.instance.currentUser;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  void getData() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('users/$uid');
    ref.onValue.listen((DatabaseEvent event){
      var img = event.snapshot.value;
    });
  }


  void uploadImage(BuildContext context) async{
    firebase_storage.Reference StorageRef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+user!.uid.toString());
    firebase_storage.UploadTask uploadTask = StorageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await StorageRef.getDownloadURL();

    ref.child(user!.uid.toString()).update({
      'profile' : newUrl.toString()
    }).then((value){
        Fluttertoast.showToast(msg: "Profile Updated");
    }).onError((error, stackTrace){
        Fluttertoast.showToast(msg: error.toString());
    });
  }

  Future pickimage(ImageSource sour) async {
    try {
      final image = await ImagePicker().pickImage(source: sour);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick an image.  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    var screen_ht = screen.size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(methods.hex("76CFE2")),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,
                      size: 23, color: Colors.white),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(802),
                  width: ScreenUtil().setWidth(397),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(74)),
                  child: Padding(
                    padding: const EdgeInsets.all(25.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        InkWell(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  var si_b_h = screen_ht * 0.25;
                                  print(context);
                                  return Container(
                                    height:
                                        ScreenUtil().setHeight(screen_ht / 4),
                                    width: ScreenUtil()
                                        .setWidth(screen.size.width),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              pickimage(ImageSource.gallery),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(width: 1)),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(50)),
                                              child: Text(
                                                "Gallery",
                                                style: TextStyle(
                                                    color: Color(
                                                        methods.hex("76CFE2"))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(20),
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              pickimage(ImageSource.camera),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(width: 1)),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(50)),
                                              child: Text(
                                                "Camara",
                                                style: TextStyle(
                                                    color: Color(
                                                        methods.hex("76CFE2"))),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    )
                                    ),
                                  );
                                }
                                ),
                            child: image != null
                                ? ClipOval(
                                    child: Image.file(
                                      image!,
                                      height: ScreenUtil().setHeight(179),
                                      width: ScreenUtil().setWidth(179),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipOval(
                                  child: Image(
                                      image: AssetImage(
                                          "assets/Image/Edit_Profile/unknown.png"),
                                      height: 169,
                                    ),
                                )),
                        SizedBox(
                          height: ScreenUtil().setHeight(76),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                            fillColor: Color(methods.hex('76CFE2')),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color(methods.hex('76CFE2')))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(methods.hex('76CFE2')),
                                  width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            fillColor: Color(methods.hex('76CFE2')),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color(methods.hex('76CFE2')))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(methods.hex('76CFE2')),
                                  width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            fillColor: Color(methods.hex('76CFE2')),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Color(methods.hex('76CFE2')))),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(methods.hex('76CFE2')),
                                  width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // suffixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(120),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  uploadImage(context);
                                },
                                child: Container(
                                  height: ScreenUtil().setHeight(70),
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(methods.hex("D9D9D9"))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.repeat),
                                      Text("Save Detail"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: ScreenUtil().setHeight(70),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(methods.hex("D9D9D9"))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete),
                                      Text("Delete Account"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
