import 'dart:convert';

import 'package:dashboard_flutter/helper/get_storage_helper.dart';
import 'package:dashboard_flutter/helper/keyboard.dart';
import 'package:dashboard_flutter/models/form_error.dart';
import 'package:dashboard_flutter/models/login_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/constant.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:dashboard_flutter/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  LoginResponse? loginResponse;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? remember = false;
  bool? _passwordVisible = false;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 15),
          buildPasswordFormField(),
          const SizedBox(height: 15),
          FormError(errors: errors),
          const SizedBox(height: 20),
          DefaultButton(
              buttonText: "Continue",
              press: () async {
                KeyboardUtil.hideKeyboard(context);
                if (emailController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "$kEmailNullError",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (!emailValidatorRegExp
                    .hasMatch(emailController.text.trim())) {
                  Fluttertoast.showToast(
                    msg: "$kInvalidEmailError",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (passwordController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "$kPassNullError",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (passwordController.text.length <= 6) {
                  Fluttertoast.showToast(
                    msg: "$kShortPassError",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  var url = Endpoints.login;

                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var data = {
                      "email": emailController.text,
                      "password": passwordController.text,
                    };

                    final apiResponse = await showDialog(
                      context: context,
                      builder: (context) => FutureProgressDialog(
                          baseClient.post(false, Endpoints.baseUrl, url, data)),
                    );

                    print(
                        "=====apiResponse==============$apiResponse============");

                    var res = jsonDecode(apiResponse);

                    if (res['success'] == true) {
                      loginResponse = loginResponseFromJson(apiResponse);

                      GetStorageHelper.setdata(loginResponse!);
                      Endpoints.box
                          .write("access_token", loginResponse!.data!.token);

                      print(
                          "====token=========${Endpoints.box.read("access_token")}==========");
                      print(
                          "====otp=========${Endpoints.box.read("otp")}==========");

                      if (loginResponse!.data!.demo == 1) {
                        Endpoints.box.write("loginTrue", true);
                        Fluttertoast.showToast(
                          msg: "Loged in successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColor.accentGreen,
                          textColor: Colors.white,
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          '/dashboard',
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Otp sent to your email..",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColor.accentGreen,
                          textColor: Colors.white,
                        );
                        Navigator.pushNamed(context, '/otp', arguments: {
                          "email": emailController.text.trim(),
                          "password": passwordController.text.trim()
                        });
                      }
                    }

                    else{
                       Fluttertoast.showToast(
                          msg: "${res['message']}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 2,
                          backgroundColor: AppColor.neturalRed,
                          textColor: Colors.white,
                        );
                    }
                  }
                }
              },
              buttonColor: AppColor.primaryColor)
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !_passwordVisible!,
      controller: passwordController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible! ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible!;
            });
          },
        ),
        hintText: "Enter your password",
        fillColor: AppColor.accentWhite,
        filled: true,
        isDense: true,
        prefixIcon: const Icon(Icons.security),
        border: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: InputDecoration(
        counterText: "",
        hintText: "Enter your email",
        fillColor: AppColor.accentWhite,
        filled: true,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.person),
        border: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        enabledBorder: outlineInputBorder(),
      ),
    );
  }
}
