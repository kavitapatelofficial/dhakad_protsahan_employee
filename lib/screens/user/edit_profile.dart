import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/helper/get_storage_helper.dart';

import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:flutter/material.dart';

import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/constant.dart';

import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // RegisterUser? registerUser;
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController Password = TextEditingController();

  XFile? _image;
  List<XFile> images = [];

  Future<void> _getImage(ImageSource name) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: name);

    setState(() {
      _image = image;
      images.add(_image!);
    });
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a Photo'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  start() {
    setState(() {
      name.text =
          "${Endpoints.box.read("name") == "" ? "" : Endpoints.box.read("name")}";
      email.text =
          "${Endpoints.box.read("email") == "" ? "" : Endpoints.box.read("email")}";
      phone.text =
          "${Endpoints.box.read("phone") == "" ? "" : Endpoints.box.read("phone")}";
    });
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBgColor,
      appBar: CustomAppBar("Update Profile"),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile Image",
                  style: Texttheme.title,
                ),
                const SizedBox(height: 15.0),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: _image == null
                            ? Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${Endpoints.imageUrl}${Endpoints.box.read("image") == "" ? "" : Endpoints.box.read("image")}",
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    backgroundColor: AppColor.neturalRed,
                                    radius: 50,
                                    child: Image.asset(
                                        "assets/images/user_placeholder.png"),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    child: Center(child: Icon(Icons.people)),
                                    radius: 50,
                                  ),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                    backgroundImage: image,
                                    radius: 50,
                                  ),
                                ),
                              )
                            : Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                              ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                _showImagePicker(context);
                              },
                              icon: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                      color: AppColor.accentWhite,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.edit,
                                    color: AppColor.accentWhite,
                                  ))))),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => name.text = newValue!,
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    isDense: true,
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.accentWhite,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => phone.text = newValue!,
                  maxLength: 15,
                  controller: phone,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    counterText: "",
                    isDense: true,
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.accentWhite,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) => email.text = newValue!,
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    isDense: true,
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.accentWhite,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) => Password.text = newValue!,
                  controller: Password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    isDense: true,
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    filled: true,
                    fillColor: AppColor.accentWhite,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  buttonText: "Edit",
                  press: () async {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      var data;
                      var data2 = {
                        'name': name.text.trim(),
                        'phone': phone.text.trim(),
                        'email': email.text.trim()
                      };

                      var data3 = {
                        'name': name.text.trim(),
                        'phone': phone.text.trim(),
                        'email': email.text.trim(),
                        'password': Password.text.trim()
                      };
                      if (Password.text.isEmpty) {
                        setState(() {
                          data = data2;
                        });
                      } else {
                        data = data3;
                      }

                      final apiResponse = await showDialog(
                        context: context,
                        builder: (context) => FutureProgressDialog(
                            baseClient.post(true, Endpoints.baseUrl,
                                Endpoints.editProfile, data)),
                      );

                      if (apiResponse != null) {
                        var jsonData = jsonDecode(apiResponse);
                        if (jsonData['success'] == true) {
                          print(
                              "=======${jsonData['data']['name']}========================");
                          print(
                              "=======${jsonData['data']['email']}========================");
                          print(
                              "=======${jsonData['data']['phone']}========================");

                          box.write('name', jsonData['data']['name']);
                          box.write('email', jsonData['data']['email']);
                          box.write('phone', jsonData['data']['phone']);

                          setState(() {});
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColor.neturalRed,
                          textColor: Colors.white,
                        );
                      }
                    }
                  },
                  buttonColor: AppColor.primaryColor,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
