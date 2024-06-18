import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';


import 'components/body.dart';
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.accentBgColor,
     
        body: const Body(),
      ),
    );
  }
}
