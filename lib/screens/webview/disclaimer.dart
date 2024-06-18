import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DesclaimerScreen extends StatefulWidget {
  @override
  State<DesclaimerScreen> createState() => _DesclaimerScreenState();
}

class _DesclaimerScreenState extends State<DesclaimerScreen> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
           elevation: 1,
      iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
      backgroundColor: AppColor.accentWhite,
      automaticallyImplyLeading: true,
        title: Text("Desclaimer",style: Texttheme.heading,),
      ),
      url: Endpoints.disclaimer,
    );
  }
}
