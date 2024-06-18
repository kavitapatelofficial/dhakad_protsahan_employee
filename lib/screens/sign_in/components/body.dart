import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';

import 'sign_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedValue = "Panel";
  Color panelselectedColor = AppColor.accentGreen;
  Color customerselectedColor = AppColor.accentLightGrey;
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .11),

                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/illustration-2.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                Text(
                  "Sign in with your email and password",
                  style: Texttheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 20),
                const SignForm(),
                const SizedBox(height: 10),
                // const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
