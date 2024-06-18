
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';

import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/appbar_without_actions.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';


class AddGiftRedemptionScreen extends StatefulWidget {
  final Map arguments;

  const AddGiftRedemptionScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AddGiftRedemptionScreen> createState() => _AddGiftRedemptionScreenState();
}

class _AddGiftRedemptionScreenState extends State<AddGiftRedemptionScreen> {
  // RegisterUser? registerUser;
  BaseClient baseClient = BaseClient();
  var formKey = GlobalKey<FormState>();

  final TextEditingController points = TextEditingController();

  final TextEditingController quantity= TextEditingController();
 

  String? contractorId = null;
  String? giftId = null;

  start() {
    if (widget.arguments['isEdit'] == true) {
      setState(() {
        points.text = "${(widget.arguments['points'])}";
        quantity.text = "${(widget.arguments['quantity'])}";
       
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Select a contractor",
                      isDense: true,
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: AppColor.accentWhite,
                    ),
                    validator: (value) =>
                        value == null ? "Select a contractor" : null,
                    value: contractorId,
                    onChanged: (String? newValue) {
                      setState(() {
                        contractorId = newValue!;
                      });
                    },
                    items: ['Kavita', 'Rahul', 'Amrita'].map((e) {
                      return DropdownMenuItem(
                          child: Text("${e}"), value: "${e}");
                    }).toList()),
                const SizedBox(height: 15.0),

                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Select a gift",
                      isDense: true,
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                      filled: true,
                      fillColor: AppColor.accentWhite,
                    ),
                    validator: (value) =>
                        value == null ? "Select a gift" : null,
                    value: giftId,
                    onChanged: (String? newValue) {
                      setState(() {
                        giftId = newValue!;
                      });
                    },
                    items: ['Gift 1', 'Gift 2', 'Gift 3'].map((e) {
                      return DropdownMenuItem(
                          child: Text("${e}"), value: "${e}");
                    }).toList()),
                const SizedBox(height: 15.0),
               
               
              
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) => points.text = newValue!,
                  
                  controller: points,
                  decoration: InputDecoration(
                    hintText: 'Enter point',
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
                      return 'point is required*';
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
                  onSaved: (newValue) => quantity.text = newValue!,
                  maxLength: 10,
                  controller: quantity,
                  decoration: InputDecoration(
                    hintText: 'Enter quantity',
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
                  buttonText:
                      widget.arguments['isEdit'] == true ? "Edit" : "Save",
                  press: () async {
                    formKey.currentState!.save();
                    if (formKey.currentState!.validate()) {
                      var data = {
                        'u_id': '',
                      };
                      final apiResponse = await showDialog(
                        context: context,
                        builder: (context) => FutureProgressDialog(
                            baseClient.post(true, Endpoints.baseUrl,
                                Endpoints.addGift, data)),
                      );

                      if (apiResponse != null) {
                        Endpoints.box.write("currentIndex", 1);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/', // The route name to push
                          (route) => false, // Pop all the previous routes
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "kk",
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
