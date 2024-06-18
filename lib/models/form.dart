import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  String? password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: 331, right: 21),
                width: 24,
                height: 24,
                color: const Color(0xff31CC44),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'We will send an OTP to your Phone Number.\nPlease enter your OTP in below box.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: const Color(0xffEFEFEF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1)),
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          filled: true,
                          hintText: 'New Password',
                          contentPadding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 25.63, right: 203.37),
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          if (value.length < 8) {
                            return 'Password should have atleast 8 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value;
                          print(password);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: const Color(0xffEFEFEF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            filled: true,
                            hintText: 'Repeat Password',
                            contentPadding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                                left: 25.63,
                                right: 203.37),
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                        validator: (value) {
                          if (value != password) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    ButtonTheme(
                      height: 50,
                      minWidth: 183,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00B4D8)),
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
