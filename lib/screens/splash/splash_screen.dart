import 'package:dashboard_flutter/helper/get_storage_helper.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GetStorageHelper.setinitialdata();
    start();

    super.initState();
  }

  start() {
    Future.delayed(Duration(seconds: 2), () {
      print("====loginTrue=========${Endpoints.box.read("loginTrue")}==========");
      Endpoints.box.read("loginTrue") != null
          ? Navigator.pushNamedAndRemoveUntil(
              context,
              '/dashboard', // The route name to push
              (route) => false, // Pop all the previous routes
            )
          : Navigator.pushNamedAndRemoveUntil(
              context,
              '/signin', // The route name to push
              (route) => false, // Pop all the previous routes
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/images/splash.jpg"))),
      ),
    );
  }
}
