import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/text_theme.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PrivcayPolicy extends StatefulWidget {
  @override
  State<PrivcayPolicy> createState() => _PrivcayPolicyState();
}

class _PrivcayPolicyState extends State<PrivcayPolicy> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
           elevation: 1,
      iconTheme: IconThemeData(color: AppColor.defaultBlackColor),
      backgroundColor: AppColor.accentWhite,
      automaticallyImplyLeading: true,
        title: Text("Privacy Policy",style: Texttheme.heading,),
      ),
      url: Endpoints.privacyPolicy,
    );
  }
}
