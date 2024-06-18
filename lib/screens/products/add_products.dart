import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_flutter/providers/products_provider.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/widgets/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';

import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {
  final Map arguments;
  const AddProductsScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController points = TextEditingController();

  final TextEditingController desc = TextEditingController();

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
    if (widget.arguments['isEdit'] == true) {
      setState(() {
        name.text = "${(widget.arguments['name'])}";
        points.text = "${(widget.arguments['points'])}";
        desc.text =
            "${(widget.arguments['desc']) == null ? "" : widget.arguments['desc']}";
      });
    }
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
        appBar: CustomAppBar(widget.arguments['title']),
        body: Consumer<ProductProvider>(builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Product Image",
                        style: Texttheme.title,
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        width: 150.0, // Set the desired width
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
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
                                                  150.0, // Set the desired width
                                              height: 150.0,
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
                                                radius: 75,
                                                child: Image.asset(
                                                    "assets/images/placeholder.png"),
                                              ),
                                              placeholder: (context, url) =>
                                                  CircleAvatar(
                                                backgroundColor:
                                                    AppColor.neturalRed,
                                                radius: 75,
                                                child: Image.asset(
                                                    "assets/images/user_placeholder.png"),
                                              ),
                                              imageBuilder: (context, image) =>
                                                  CircleAvatar(
                                                backgroundImage: image,
                                                radius: 75,
                                              ),
                                            )
                                      : const Center(
                                          child: Text("Upload  product image"))
                                  : Image.file(
                                      File(_image!.path),
                                      width: 150.0, // Set the desired width
                                      height: 150.0,
                                      fit: BoxFit.cover,
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
                        onSaved: (newValue) => name.text = newValue!,
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Enter your product name',
                          isDense: true,
                          border: outlineInputBorder(),
                          focusedBorder: outlineInputBorder(),
                          enabledBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: AppColor.accentWhite,
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Product name is Required*';
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
                        onSaved: (newValue) => points.text = newValue!,
                        maxLength: 10,
                        controller: points,
                        decoration: InputDecoration(
                          hintText: 'Enter points',
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
                            return 'Points is Required*';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                              'points': points.text.trim(),
                            };

                            var data2 = {
                              'name': name.text.trim(),
                              'points': points.text.trim(),
                              "id": "${(widget.arguments['id'])}"
                            };

                            var data = widget.arguments['isEdit'] == true
                                ? data2
                                : data1;
                            var url = widget.arguments['isEdit'] == true
                                ? Endpoints.editProduct
                                : Endpoints.addProduct;

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
                              provider.fetchProduct();
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
                    ],
                  ),
                ),
              ),
            );
          }
        }));
  }
}
