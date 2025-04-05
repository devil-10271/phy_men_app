
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:intl/intl.dart";
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
  final  String googleApiKey = "AIzaSyAwD0a-QAIPS2tu1XX_jiJxVtgCuWQ5ZEw";
  final user = FirebaseAuth.instance.currentUser;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('users');
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? profileImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
    _fetchUserDetails();
  }
  Future<void> _selectDate(BuildContext context)async{
    DateTime? pickedDate = await showDatePicker(
        builder: (context, child){
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.teal,
                hintColor: Colors.teal,
                colorScheme: ColorScheme.light(
                    primary: Colors.teal,
                  onPrimary: Colors.teal.shade50,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal
                  )
                )
              ),
              child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      context: context

    );
    if(pickedDate != null){
      setState(() {
    _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    };
  }
  Future<void> _fetchUserData() async{
    if(uid != null){
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('users/$uid');
      DataSnapshot snapshot = await ref.get();

      if(snapshot.exists){
        setState(() {
          _emailController.text = snapshot.child('email').value.toString();
          _usernameController.text = snapshot.child('uname').value.toString();
          profileImageUrl = snapshot.child('profile').value.toString();
        });
      }
    }
  }

  Future<void> _fetchUserDetails() async{
    if (uid != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child('users/$uid/details');
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        setState(() {
          _fnameController.text = snapshot.child('f_name').value.toString();
          _lnameController.text = snapshot.child('l_name').value.toString();
          _dobController.text = snapshot.child('dob').value.toString();
          _contactController.text = snapshot.child('contact_no').value.toString();
          _addressController.text = snapshot.child('address').value.toString();
        });
      }
    }
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

  Future<void> _saveChanges() async{
    if(!_validateFields()) return;

    if(uid != null)
      {
        try{
          DatabaseReference ref = FirebaseDatabase.instance.ref().child('users/$uid');
          await ref.update({
            'email': _emailController.text,
            'uname': _usernameController.text,
          });
          Fluttertoast.showToast(msg: "Profile Updated");
        } catch (e)
    {
      Fluttertoast.showToast(msg: e.toString());
    }

      }
  }
  Future<void> _saveDetails() async {
    if (!_validateFields()) return;

    if (uid != null) {
      try {
        DatabaseReference ref = FirebaseDatabase.instance.ref().child('users/$uid/details');
        await ref.update({
          'f_name': _fnameController.text.trim(),
          'l_name': _lnameController.text.trim(),
          'dob': _dobController.text.trim(),
          'contact_no': _contactController.text.trim(),
          'address': _addressController.text.trim(),
        });
        Fluttertoast.showToast(msg: "Profile Updated Successfully");
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      }
    }
  }

  bool _validateFields() {
    if (_emailController.text.isEmpty || _usernameController.text.isEmpty || _lnameController.text.isEmpty || _fnameController.text.isEmpty || _dobController.text.isEmpty || _contactController.text.isEmpty || _addressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill in all fields");
      return false;
    }
    if(!EmailUtils.isEmail(_emailController.text.trim())){
      Fluttertoast.showToast(msg: "Please enter a valid email");
      return false;
    }
    return true;
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
                padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,
                      size: 23, color: Colors.white),
                ),
              ),
              
              Center(
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:15),
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.5),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
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
                                  child: ClipOval(
                                    child: image != null
                                        ? Image.file(
                                      image!,
                                      height: ScreenUtil().setHeight(150),
                                      width: ScreenUtil().setWidth(150),
                                      fit: BoxFit.cover,
                                    )
                                        : profileImageUrl != null
                                        ? Image.network(
                                        profileImageUrl!,
                                      height: ScreenUtil().setHeight(150),
                                      width: ScreenUtil().setWidth(150),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress){
                                          if(loadingProgress == null) return child;
                                          return CircularProgressIndicator();
                                      },
                                      errorBuilder: (context, error, stackTrace){
                                          return Image.asset(
                                            'assets/Image/Edit_Profile/unknown.png',
                                            height: ScreenUtil().setWidth(150),
                                            width: ScreenUtil().setWidth(150),
                                            fit: BoxFit.cover,
                                          );
                                      },
                                    )
                                        :Image.asset(
                                      'assets/Image/Edit_Profile/unknown.png',
                                      height: ScreenUtil().setWidth(150),
                                      width: ScreenUtil().setWidth(150),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              TextFormField(
                                controller: _usernameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  hintText: "Username",
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
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  hintText: "Email",
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
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _fnameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  hintText: "FirstName",
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
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _lnameController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                  ),
                                  hintText: "Last Name",
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
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _dobController,
                                readOnly: true,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.calendar_today,
                                  ),
                                  hintText: "Date Of Birth",
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
                                onTap: () => _selectDate(context),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _contactController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                  ),
                                  hintText: "Contact No.",
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
                                height: ScreenUtil().setHeight(10),
                              ),
                              TextFormField(
                                controller: _addressController,
                                maxLines: 3,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                  ),
                                  hintText: "Address",
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
                                            Text("Save Profile Pic"),
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
                                      onTap: () {
                                        _saveChanges();
                                        _saveDetails();
                                      },
                                      child: Container(
                                        height: ScreenUtil().setHeight(70),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color(methods.hex("D9D9D9"))),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.save),
                                            Text("Save User Details"),
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
