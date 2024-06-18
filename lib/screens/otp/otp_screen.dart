import 'dart:convert';

import 'package:dashboard_flutter/helper/get_storage_helper.dart';
import 'package:dashboard_flutter/models/login_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final String password;

  OtpScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();
  BaseClient baseClient = BaseClient();
  LoginResponse? loginResponse;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-3.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code sent to your email",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                            first: true,
                            last: false,
                            context: context,
                            controller: controller1),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: controller2),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: controller3),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: controller4),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: controller5),
                        _textFieldOTP(
                            first: false,
                            last: true,
                            context: context,
                            controller: controller6),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller1.text.isNotEmpty &&
                              controller2.text.isNotEmpty &&
                              controller3.text.isNotEmpty &&
                              controller4.text.isNotEmpty &&
                              controller6.text.isNotEmpty &&
                              controller6.text.isNotEmpty) {
                            var otp =
                                "${controller1.text.trim()}${controller2.text.trim()}${controller3.text.trim()}${controller4.text.trim()}${controller5.text.trim()}${controller6.text.trim()}";
                            var otp2 = "${Endpoints.box.read("otp")}";
                            print(
                                "========otp= $otp=========otp2========$otp2=========");
                            if (otp == otp2) {
                              Endpoints.box.write("loginTrue", true);
                              Fluttertoast.showToast(
                                msg: "Otp verified successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 2,
                                backgroundColor: AppColor.accentGreen,
                                textColor: Colors.white,
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/dashboard", (route) => false);
                            } else {
                              Fluttertoast.showToast(
                                msg: "Invalid otp",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 2,
                                backgroundColor: AppColor.neturalOrange,
                                textColor: Colors.white,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please enter otp",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AppColor.neturalOrange,
                              textColor: Colors.white,
                            );
                          }
                          //
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              TextButton(
                onPressed: () async {
                  var url = Endpoints.login;

                  var data = {
                    "email": "${email}",
                    "password": "$password",
                  };

                  print("===========data========$data=================");

                  final apiResponse = await showDialog(
                    context: context,
                    builder: (context) => FutureProgressDialog(
                        baseClient.post(false, Endpoints.baseUrl, url, data)),
                  );

                  print(
                      "=====apiResponse==============$apiResponse============");

                  var res = jsonDecode(apiResponse);

                  if (res['success'] == true) {
                    Fluttertoast.showToast(
                      msg: "Resend OTP successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 2,
                      backgroundColor: AppColor.accentGreen,
                      textColor: Colors.white,
                    );
                    loginResponse = loginResponseFromJson(apiResponse);

                    GetStorageHelper.setdata(loginResponse!);
                    Endpoints.box
                        .write("access_token", loginResponse!.data!.token);

                    print(
                        "====token=========${Endpoints.box.read("access_token")}==========");
                    print(
                        "====otp=========${Endpoints.box.read("otp")}==========");
                  }
                },
                child: Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {bool? first,
      last,
      BuildContext? context,
      TextEditingController? controller}) {
    return Container(
      height: 69,
      width: 49,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context!).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context!).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
