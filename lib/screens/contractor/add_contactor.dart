import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/providers/contractor_provider.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:dashboard_flutter/widgets/showdialog.dart';
import 'package:dashboard_flutter/widgets/user_profile_widget.dart';
import 'package:flutter/material.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class AddContractorScreen extends StatefulWidget {
  final Map arguments;

  const AddContractorScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AddContractorScreen> createState() => _AddContractorScreenState();
}

class _AddContractorScreenState extends State<AddContractorScreen> {
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();

  final TextEditingController number2 = TextEditingController();

  final TextEditingController address = TextEditingController();
   final TextEditingController cIdcontroller = TextEditingController();

  XFile? _image;
  List<XFile> images = [];

  start() {
    if (widget.arguments['isEdit'] == true) {
      print("========${widget.arguments['number2'] == "null"}===============");
      setState(() {
         cIdcontroller.text =
            "${(widget.arguments['cId']) == "null" ? "" : (widget.arguments['cId'])}";
        name.text =
            "${(widget.arguments['name']) == "null" ? "" : (widget.arguments['name'])}";

        number.text =
            "${(widget.arguments['number']) == "null" ? "" : (widget.arguments['number'])}";
        number2.text =
            "${widget.arguments['number2'] == "null" ? "" : widget.arguments['number2']}";
        address.text =
            "${(widget.arguments['address']) == "null" ? "" : (widget.arguments['address'])}";
      });
    }
  }

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

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColor.accentBgColor,
        appBar: CustomAppBar(widget.arguments['title']),
        body: Consumer<ContractorProvider>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return SizedBox(
              height: size.height,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Contractor Image",
                        style: Texttheme.title,
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: 120.0, // Set the desired width
                        height: 120.0, // Set the desired height
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 1.0,
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(75),
                              child: _image == null
                                  ? widget.arguments['isEdit'] == true
                                      ? widget.arguments['image'] == null
                                          ? Image.asset(
                                              "assets/images/placeholder.jpg",
                                              width:
                                                  120.0, // Set the desired width
                                              height: 120.0,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              imageUrl:
                                                  "${Endpoints.imageUrl}" +
                                                      widget.arguments['image'],
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                backgroundColor:
                                                    AppColor.neturalRed,
                                                radius: 60,
                                                child: Image.asset(
                                                    "assets/images/user_placeholder.png"),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircleAvatar(
                                                backgroundColor:
                                                    AppColor.neturalRed,
                                                radius: 60,
                                                child: Image.asset(
                                                    "assets/images/user_placeholder.png"),
                                              ),
                                              imageBuilder: (context, image) =>
                                                  CircleAvatar(
                                                backgroundImage: image,
                                                radius: 60,
                                              ),
                                            )
                                      : const Center(
                                          child: Text("Upload image"))
                                  : Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                      width: 120.0, // Set the desired width
                                      height: 120.0, // Set the desired height
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
                                          borderRadius:
                                              BorderRadius.circular(3),
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
                              controller: cIdcontroller,
                              decoration: InputDecoration(
                                hintText: 'Enter contractor Id',
                                isDense: true,
                                border: outlineInputBorder(),
                                focusedBorder: outlineInputBorder(),
                                enabledBorder: outlineInputBorder(),
                                filled: true,
                                fillColor: AppColor.accentWhite,
                              ),
                               validator: (text) {
                          if (text!.isEmpty) {
                            return 'contractor Id  is Required*';
                          } else {
                            return null;
                          }
                        },
                            ),
                         
                     SizedBox(
                              height: 10,
                            ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) => name.text = newValue!,
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Enter contractor name',
                          isDense: true,
                          border: outlineInputBorder(),
                          focusedBorder: outlineInputBorder(),
                          enabledBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: AppColor.accentWhite,
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'contractor name is Required*';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => number.text = newValue!,
                        maxLength: 10,
                        controller: number,
                        decoration: InputDecoration(
                          hintText: 'Enter mobile',
                          counterText: "",
                          isDense: true,
                          border: outlineInputBorder(),
                          focusedBorder: outlineInputBorder(),
                          enabledBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: AppColor.accentWhite,
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'mobile is required*';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => number2.text = newValue!,
                        maxLength: 10,
                        controller: number2,
                        decoration: InputDecoration(
                          hintText: 'Enter alternate mobile',
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
                        keyboardType: TextInputType.text,
                        onSaved: (newValue) => address.text = newValue!,
                        minLines: 1,
                        maxLines: null,
                        controller: address,
                        decoration: InputDecoration(
                          hintText: 'Enter address',
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
                      DefaultButton(
                        buttonText: widget.arguments['isEdit'] == true
                            ? "Edit"
                            : "Save",
                        press: () async {
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate()) {
                            var data1 = {
                              'name': name.text.trim(),
                              'alternate_number': number2.text.trim(),
                              'number': number.text.trim(),
                              'address': address.text.trim(),
                               "c_id": cIdcontroller.text.trim(),
                            };

                            var data2 = {
                              'name': name.text.trim(),
                              'alternate_number': number2.text.trim(),
                              'number': number.text.trim(),
                              'address': address.text.trim(),
                              "id": "${(widget.arguments['id'])}",
                              "c_id": cIdcontroller.text.trim(),
                            };

                            var data = widget.arguments['isEdit'] == true
                                ? data2
                                : data1;
                            var url = widget.arguments['isEdit'] == true
                                ? Endpoints.editContractor
                                : Endpoints.addContractor;

                            print("=========data=======$data===========");
                            print("=========url======$url===========");
                            final apiResponse = await showDialog(
                              context: context,
                              builder: (context) => FutureProgressDialog(
                                  baseClient.postMultipart(true,
                                      Endpoints.baseUrl, url, data, images)),
                            );

                            var res = jsonDecode(apiResponse);

                            if (res['success'] == true) {
                              provider.fetchContractors();
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      success: true,
                                      title: "Dialog Title",
                                      content: "${res['message']}",
                                    );
                                  },
                                );
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    success: false,
                                    title: "Dialog Title",
                                    content: "${res['message']}",
                                  );
                                },
                              );
                            }
                          }
                        },
                        buttonColor: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.arguments['isEdit'] == true
                          ? UserProfileData(
                              isShow: true,
                              name:
                                  '${(widget.arguments['name']) == "null" ? "NA" : (widget.arguments['name'])}',
                              points:
                                  '${(widget.arguments['points']) == "null" ? "NA" : (widget.arguments['points'])}',
                              phone:
                                  '${(widget.arguments['number']) == "null" ? "NA" : (widget.arguments['number'])}',
                              cId:
                                  '${(widget.arguments['cId']) == "null" ? "NA" : (widget.arguments['cId'])}',
                              alternateNumber:
                                  '${(widget.arguments['number2']) == "null" ? "NA" : (widget.arguments['number2'])}',
                              address:
                                  '${(widget.arguments['address']) == "null" ? "NA" : (widget.arguments['address'])}',
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }));
  }
}
